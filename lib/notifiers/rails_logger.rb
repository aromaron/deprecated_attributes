# frozen_string_literal: true

# Extend Rails logger
module Arda
  # Log Subscriber
  class LogSubscriber < ActiveSupport::LogSubscriber
    def logger_config
      Arda.configuration.rails_logger || {}
    end

    def log_color(text, color, bold: true)
      logger_config[:color] ? color(text, color, bold) : text
    end

    def log_method(msg, level = :info)
      log_level = %i[debug info warn error fatal].include?(level) ? level : :unknown
      send(log_level, msg)
    end

    def format_message(payload)
      title = log_color("DEPRECATION WARNING:", YELLOW)
      klass_str = log_color(payload[:klass], CYAN)
      attr_str = log_color(payload[:attribute], BLUE)
      args_str = log_color(payload[:args], MAGENTA)
      msg_str = payload[:msg] ? "#{log_color("DEPRECATION DETAILS:", YELLOW)} #{log_color(payload[:msg], MAGENTA)}" : ""

      backtrace = payload[:backtrace].join("\n")
      ["\n#{title} `#{attr_str}` is deprecated. Was called on #{klass_str} with args: #{args_str}\n#{msg_str}",
        backtrace].join("\n")
    end

    def deprecated_attributes(event)
      deprecation_message = format_message(event.payload)

      log_method(deprecation_message, logger_config[:level])
    end

    def logger
      ActiveRecord::Base.logger
    end
  end
end

Arda::LogSubscriber.attach_to :active_record if Arda.configuration.enable
