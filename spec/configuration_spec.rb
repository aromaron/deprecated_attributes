# frozen_string_literal: true

require "spec_helper"

RSpec.describe "DeprecatedAttributes" do
  describe "Configuration" do
    before { DeprecatedAttributes.reset }

    it "has default params" do
      expect(DeprecatedAttributes.configuration.enable).to be(true)
      expect(DeprecatedAttributes.configuration.raise).to be(false)
      expect(DeprecatedAttributes.configuration.rails_logger).to eq({level: :debug, color: true})
    end

    it "allows custom params" do
      DeprecatedAttributes.configure do |config|
        config.enable = false
        config.raise = true
        config.rails_logger = {level: :error}
      end

      expect(DeprecatedAttributes.configuration.enable).to be(false)
      expect(DeprecatedAttributes.configuration.raise).to be(true)
      expect(DeprecatedAttributes.configuration.rails_logger).to eq({level: :error})
    end
  end
end
