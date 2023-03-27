# frozen_string_literal: true

require "active_record"
require "deprecated_attributes"

# rubocop:disable Style/ClassAndModuleChildren
# Override ActiveRecord arttribute_methods
class ActiveRecord::Base
  include DeprecatedAttributes

  def attribute_names
    self.class.attribute_names.reject { |attr| self.class.deprecated_attributes.include?(attr.to_sym) }
  end

  def serializable_hash(options = {})
    options = {} if options.nil?

    options[:only] = attributes.keys.map(&:to_sym) - (self.class.deprecated_attributes || []).map(&:to_sym)

    super(options)
  end

  def attribute_for_inspect(attr_name)
    return super unless self.class.deprecated_attributes.include?(attr_name.to_sym)

    attr_name = attr_name.to_s
    attr_name = self.class.attribute_aliases[attr_name] || attr_name
    last_value = _read_attribute(attr_name)

    value = "DEPRECATED with value: #{last_value}"

    format_for_inspect(attr_name, value)
  end
end
# rubocop:enable Style/ClassAndModuleChildren
