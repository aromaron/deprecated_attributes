# frozen_string_literal: true

require "spec_helper"

# rubocop:disable Metrics/BlockLength
RSpec.describe DeprecatedAttributes do
  before do
    DeprecatedAttributes.configuration.raise = false
  end

  describe "Model" do
    it "doesn't have any deprecated attributes initially" do
      expect(Person.deprecated_attributes).to eq([])
    end

    it "calling deprecated_attribute alone doesn't raise an error" do
      Person.class_eval do
        deprecated_attribute
      end

      expect(Person.deprecated_attributes).to eq([])
    end

    it "will have deprecated_attribute defined" do
      expect(User.methods).to include(:deprecated_attribute)
    end

    it "includes deprecated attributes as class instance_methods " do
      expect(User.instance_methods).to include(:test_deprecated_attribute)
    end

    it "includes defined deprecated attributes when calling deprecated_attributes on a class" do
      expect(User.deprecated_attributes).to include(:test_deprecated_attribute)
    end

    # Make sure this is always at the bottom otherwise will break other tests
    it "can clear deprecated attributes" do
      User.clear_deprecated_attributes!
      expect(User.deprecated_attributes).to eq([])
    end
  end
end
# rubocop:enable Metrics/BlockLength
