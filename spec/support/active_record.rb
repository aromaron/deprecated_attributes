# frozen_string_literal: true

require "active_record"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
ActiveRecord::Schema.verbose = false

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
    t.string :test_deprecated_attribute
    t.string :another_deprecated_attribute
  end
end

ActiveRecord::Schema.define do
  create_table :people, force: true do |t|
    t.string :name
    t.string :test_not_deprecated_attribute
  end
end
