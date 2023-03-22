# frozen_string_literal: true

require "active_support"
require "active_record"

require_relative "arda/version"
require_relative "arda/errors"
require_relative "arda/configuration"
require_relative "arda/active_record_extension"

require "notifiers/rails_logger"

# Active Record Deprecated Attribute Module
module Arda
  extend ActiveSupport::Concern

  included do
    class_attribute :_deprecated_attributes, instance_writer: false
  end

  def self.included(base)
    base.extend ClassMethods
  end

  # Class Methods Definitions
  module ClassMethods
    # Safely marks an attribute as deprecated (non-destructive).
    def deprecated_attribute(attrs = [], message: nil)
      # pre-initialize any deprecated attributes
      attributes = Set.new(ensure_array(attrs).compact)
      @deprecated_attributes ||= Set.new

      # pre-initialize a new instance of our ActiveRecord model from `attributes`
      new(attributes.zip(attributes.map {}).to_h) if defined?(ActiveRecord) && ancestors.include?(ActiveRecord::Base)

      # Taking the difference of the two sets ensures we don't deprecate the same attribute more than once
      (attributes - deprecated_attributes).each do |attribute|
        override_deprecated_attribute(attribute, message)
      end

      @deprecated_attributes += attributes
    end

    # return a list of all deprecated attributes for this class
    def deprecated_attributes
      (@deprecated_attributes || Set.new).to_a
    end

    # check if the passed attribute is defined
    def deprecated_attribute?(attribute)
      @deprecated_attributes.include?(attribute)
    end

    # clears deprecated attributes for this class
    def clear_deprecated_attributes!
      @deprecated_attributes.clear
    end

    def accessors
      ["", "=", "_before_type_cast", "?", "_changed?", "_change", "_will_change!", "_was"]
    end

    # Wrap the original attribute method with appropriate notification and errors
    def override_deprecated_attribute(attribute, message)
      accessors.each do |term|
        original_attribute_method = instance_method("#{attribute}#{term}")
        define_method("#{attribute}#{term}") do |*args|
          backtrace = ActiveSupport::BacktraceCleaner.new.clean(caller)
          self.class.notify_deprecated_attribute(klass: self.class, attribute: attribute,
            args: args, backtrace: backtrace, msg: message)
          self.class.raise_deprecated_attribute

          original_attribute_method.bind_call(self, *args)
        end
      end
    end

    # Dispatch a notification to the the Rails Logger
    def notify_deprecated_attribute(payload)
      ActiveSupport::Notifications.instrument("deprecated_attributes.active_record", payload)
    end

    # Raises a DeprecatedAttributeError if Arda is configurated to do so.
    def raise_deprecated_attribute
      raise DeprecatedAttributeError if Arda.configuration.raise
    end

    private

    def ensure_array(value)
      value.is_a?(Array) ? value : [value]
    end
  end
end
