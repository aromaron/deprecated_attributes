# frozen_string_literal: true

# Configuration for Arda
module Arda
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Allows configuration options to be set using a block.
  def self.configure
    yield(configuration)
  end

  # Resets current configuration to default values.
  def self.reset
    @configuration = Configuration.new
  end

  # Configuration class to define log and error preferences.
  # Enable: whether or not to show logs
  # Full Trace: show full trace of error
  # Raise: To raise a DeprecatedAttributeError
  # Rails Logger: To customize logger output
  class Configuration
    attr_accessor :enable, :full_trace, :raise, :rails_logger

    def initialize
      @enable = true
      @full_trace = false
      @raise = false
      @rails_logger = default_rails_logger_config
    end

    private

    def default_rails_logger_config
      {level: :debug, color: true}
    end
  end
end
