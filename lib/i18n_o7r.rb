require 'yaml/store'

BOOTSTRAP_CSS_CDN_URL = '//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css'
BOOTSTRAP_JS_CDN_URL  = '//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js'
JQUERY_JS_CDN_URL     = 'https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js'
DEFAULT_MISSING_INDICATOR = '[*] '

module I18nO7r
  mattr_accessor :dump_location
  mattr_accessor :password
  mattr_accessor :username
  mattr_accessor :locales_root
  mattr_accessor :primary_language
  mattr_accessor :languages
  mattr_accessor :configured
  mattr_accessor :missing_indicator
  mattr_accessor :bootstrap_css_url
  mattr_accessor :bootstrap_js_url
  mattr_accessor :jquery_js_url
  mattr_accessor :save_missing_translations_in_envs
  mattr_accessor :missing_translations_filename
  mattr_accessor :ignore_missing_pattern

  @@languages                 = I18n.available_locales
  @@primary_language          = I18n.locale
  @@bootstrap_js_url          = BOOTSTRAP_JS_CDN_URL
  @@bootstrap_css_url         = BOOTSTRAP_CSS_CDN_URL
  @@jquery_js_url             = JQUERY_JS_CDN_URL
  @@missing_indicator         = DEFAULT_MISSING_INDICATOR
  @@save_missing_translations_in_envs = %w{development}
  @@missing_translations_filename = nil

  def self.configure
    yield(self)
    if !dump_location || !locales_root || !primary_language || !languages
      raise "For I18nO7r to work properly, you need to configure dump_location, locales_root, primary_language and languages"
    end
    @@configured = true
  end

  def self.ignore_missing_if(&block)
    @@ignore_missing_pattern = block
  end
end

require_relative "./i18n_o7r/engine.rb"
require_relative "./i18n_o7r/store.rb"
require_relative "./i18n_o7r/hash_deep_count.rb"
require_relative "./i18n/find_missing_translations.rb"
