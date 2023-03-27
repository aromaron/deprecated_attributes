# frozen_string_literal: true

class Person < ActiveRecord::Base
  include DeprecatedAttributes
end
