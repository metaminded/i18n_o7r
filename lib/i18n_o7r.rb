require 'yaml/store'

# https://getbootstrap.com/docs/3.4/getting-started/#download-cdn
BOOTSTRAP_CSS_CDN_URL       = "https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css"
BOOTSTRAP_CSS_CDN_INTEGRITY = "sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu"
BOOTSTRAP_JS_CDN_URL        = "https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"
BOOTSTRAP_JS_CDN_INTEGRITY  = "sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd"

# https://releases.jquery.com/
JQUERY_CDN_URL              = "https://code.jquery.com/jquery-3.6.0.slim.min.js"
JQUERY_CDN_INTEGRITY        = "sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI="

module I18nO7r
  mattr_accessor :dump_location
  mattr_accessor :password
  mattr_accessor :username
  mattr_accessor :locales_root
  mattr_accessor :primary_language
  mattr_accessor :languages
  mattr_accessor :configured
  mattr_accessor :bootstrap_css_url
  mattr_accessor :bootstrap_css_integrity
  mattr_accessor :bootstrap_js_url
  mattr_accessor :bootstrap_js_integrity
  mattr_accessor :jquery_url
  mattr_accessor :jquery_integrity
  mattr_accessor :save_missing_translations_in_envs
  mattr_accessor :missing_translations_filename
  mattr_accessor :ignore_missing_pattern
  mattr_accessor :flatten_after
  mattr_accessor :replace_all_with
  mattr_accessor :keep_backup

  @@languages                 = I18n.available_locales
  @@primary_language          = I18n.locale
  @@bootstrap_js_url          = BOOTSTRAP_JS_CDN_URL
  @@bootstrap_js_integrity    = BOOTSTRAP_JS_CDN_INTEGRITY
  @@bootstrap_css_url         = BOOTSTRAP_CSS_CDN_URL
  @@bootstrap_css_integrity   = BOOTSTRAP_CSS_CDN_INTEGRITY
  @@jquery_url                = JQUERY_CDN_URL
  @@jquery_integrity          = JQUERY_CDN_INTEGRITY
  @@save_missing_translations_in_envs = %w{development}
  @@missing_translations_filename = nil
  @@keep_backup               = false

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

  def self.requested_keys
    RequestStore.store[:_i18n_o7r_requested_keys] ||= Set.new
  end
end

require_relative "./i18n_o7r/engine.rb"
require_relative "./i18n_o7r/store.rb"
require_relative "./i18n_o7r/hash_deep_count.rb"
require_relative "./i18n/find_missing_translations.rb"
