# frozen_string_literal: true

class User < ActiveRecord::Base
  include DeprecatedAttributes

  deprecated_attribute [:test_deprecated_attribute, :another_deprecated_attribute], message: 'test message'
end
