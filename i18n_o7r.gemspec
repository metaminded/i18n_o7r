$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "i18n_o7r/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "i18n_o7r"
  s.version     = I18nO7r::VERSION
  s.authors     = ["Peter Horn"]
  s.email       = ["peter.horn@provideal.net"]
  s.homepage    = "https://github.com/metaminded/i18n_o7r"
  s.summary     = "The Internationalization Organizer"
  s.description = "I18nO7r is supposed to make life easier by organizing the i18n ymls in a very strict manner, allowing to edit the translations interactively and automatically detect missing locales as-you-use."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
end
