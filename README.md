# DeprecatedAttributes (WIP)

**This is a work in progress and learning exercise** DeprecatedAttributes provides a straightforward and unobtrusive method for flagging deprecated attributes in your model. When these attributes are accessed, a deprecation warning message will be logged. Additionally, an exception can be raised if desired along with a trace of where the deprecated attribute was called.

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

## Configuration

You can use the configure method and pass a block that takes a config parameter. Within this block, you can set various options for DeprecatedAttributes.

`enable:` Set this option to true to enable some feature.

`full_trace:` Set this option to false to disable full trace.

`raise:` Set this option to false to disable the raising of errors.

`rails_logger:` Set the level for debug and colored output.

Example usage:

```ruby
# default values

DeprecatedAttributes.configure do |config|
  config.enable = true
  config.full_trace = false
  config.raise = false
  config.rails_logger = {
    level: :debug,
    color: true
  }
end

```

## Usage

**In your model:**

```ruby

class User < ActiveRecord::Base
  include DeprecatedAttributes

  # this works
  deprecated_attribute :first_name, message: "name was deprecated in favor of name"

  # you can wrap two or more attributes in an array
  deprecated_attribute [:address_1, :address_2], message: "no longer need for addressess"
  # or
  deprecated_attribute %i[address_1 address_2], message: "no longer need for addressess"

  # this wont work
  deprecated_attribute :address_1, :address_2, message: "no longer need for addressess"
end

```

**Examples**:

    > User.deprecated_attributes
    => [:first_name]

    > User.deprecated_attribute? :first_name
    => true

    > user = User.first
    > user.first_name

    => DEPRECATION WARNING: `first_name` is deprecated. Was called on User with args: []
    => DEPRECATION DETAILS: first_name was deprecated in favor of name

    # if DeprecatedAttributes.configuration.raise = true
    => DeprecatedAttributes::DeprecatedAttributeError: DeprecatedAttributes::DeprecatedAttributeError




## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aromaron/deprecated_attributes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/aromaron/deprecated_attributes/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DeprecatedAttributes project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aromaron/deprecated_attributes/blob/main/CODE_OF_CONDUCT.md).
