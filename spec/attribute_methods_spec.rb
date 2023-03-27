# frozen_string_literal: true

require "spec_helper"
# rubocop:disable Metrics/BlockLength
RSpec.describe DeprecatedAttributes do
  before do
    DeprecatedAttributes.configuration.raise = false
  end

  describe "Attribute Methods" do
    let(:user) { User.new(name: "john", test_deprecated_attribute: "data") }
    let(:person) { Person.new(name: "john", test_not_deprecated_attribute: "data") }

    it "exclude deprecated attributes from serializable_hash" do
      expect(User).to receive(:notify_deprecated_attribute).exactly(1).times
      expect(user.serializable_hash).to_not include("test_deprecated_attribute")
    end

    it "exclude deprecated attributes from attribute_names" do
      expect(User).to receive(:notify_deprecated_attribute).exactly(1).times
      expect(user.attribute_names).to_not include("test_deprecated_attribute")
    end

    it "non deprecated class keeps all its attributes from serializable_hash" do
      expect(person.serializable_hash).to include("test_not_deprecated_attribute")
    end

    it "non deprecated class keeps all its attributes from attribute_names" do
      expect(person.attribute_names).to include("test_not_deprecated_attribute")
    end

    it "warns deprecated attributes from attribute_for_inspect" do
      expect(User).to receive(:notify_deprecated_attribute).exactly(1).times
      expect(user.attribute_for_inspect(:test_deprecated_attribute)).to eq('"DEPRECATED with value: data"')
    end

    it "allows inspection on non deprecated attributes from attribute_for_inspect" do
      expect(person.attribute_for_inspect(:test_not_deprecated_attribute)).to eq('"data"')
    end
  end
end
# rubocop:enable Metrics/BlockLength
