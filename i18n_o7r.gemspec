$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "i18n_o7r/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "i18n_o7r"
  s.version     = I18nO7r::VERSION
  s.authors     = ["Peter Horn"]
  s.email       = ["peter.horn@provideal.net"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of I18nO7r."
  s.description = "TODO: Description of I18nO7r."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end
