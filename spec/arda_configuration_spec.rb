# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Arda" do
  describe "Configuration" do
    before { Arda.reset }

    it "has default params" do
      expect(Arda.configuration.enable).to be(true)
      expect(Arda.configuration.raise).to be(false)
      expect(Arda.configuration.rails_logger).to eq({level: :debug, color: true})
    end

    it "allows custom params" do
      Arda.configure do |config|
        config.enable = false
        config.raise = true
        config.rails_logger = {level: :error}
      end

      expect(Arda.configuration.enable).to be(false)
      expect(Arda.configuration.raise).to be(true)
      expect(Arda.configuration.rails_logger).to eq({level: :error})
    end
  end
end
