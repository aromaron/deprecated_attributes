# frozen_string_literal: true

require "spec_helper"
RSpec.describe "DeprecatedAttributes Implementation" do
  before do
    ActiveRecord::Base.logger ||= Logger.new($stdout)
  end

  describe "User" do
    let(:user) { User.new }

    it "triggers deprecation warning on attribute call" do
      DeprecatedAttributes.configuration.raise = false

      expect(user).to receive(:test_deprecated_attribute).exactly(1).times.and_call_original
      expect(User).to receive(:notify_deprecated_attribute).exactly(1).times

      expect(user).to_not receive(:test_deprecated_attribute=)
      expect(user.test_deprecated_attribute).to eq(nil)
    end

    it "raises deprecation error on attribute call" do
      DeprecatedAttributes.configuration.raise = true

      expect(User).to receive(:notify_deprecated_attribute).exactly(1).times

      expect { user.test_deprecated_attribute }.to(raise_error) do |error|
        expect(error).to be_a(DeprecatedAttributes::DeprecatedAttributeError)
      end
    end
  end
end
