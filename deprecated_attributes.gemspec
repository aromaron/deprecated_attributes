# frozen_string_literal: true

require_relative "lib/deprecated_attributes/version"

Gem::Specification.new do |spec|
  spec.name = "deprecated_attributes"
  spec.version = DeprecatedAttributes::VERSION
  spec.authors = ["Nora Alvarado"]
  spec.email = ["nora.alvarado@hey.com"]

  spec.summary = "DeprecatedAttributes is library to deprecate attributes"
  spec.description = "DeprecatedAttributes provides a straightforward and unobtrusive method for flagging deprecated attributes in your model. When these attributes are accessed, a warning message will be logged along with a trace of where the deprecated attribute was called. Additionally, an exception can be raised if desired."
  spec.homepage = "https://github.com/aromaron/deprecated_attributes"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = "https://github.com/aromaron/deprecated_attributes"
  spec.metadata["source_code_uri"] = "https://github.com/aromaron/deprecated_attributes"
  spec.metadata["changelog_uri"] = "https://github.com/aromaron/deprecated_attributes/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_dependency "activesupport", "~> 7.0.0"

  spec.add_development_dependency "activerecord", "~> 7.0.0"
  spec.add_development_dependency "pry", "~> 0.14.2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3", "~> 1.6.0"
  spec.add_development_dependency "standard", "~> 1.3"
end
