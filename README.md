# I18nO7r – The Internationalization Organizer

I18nO7r is supposed to make life easier by

* organizing the i18n ymls in a very strict manner.
* allowing to edit the translations interactively.
* automatically detect missing locales as-you-use.

## Setup

add to your Gemfile:

<pre>
  gem 'i18n_o7r', github: 'metaminded/i18n_o7r'
</pre>

add to you routes:

<pre>
  mount I18nO7r::Engine, at: '/i18n_o7r'
</pre>

add an initializer (no generator so far):

<pre>
  I18nO7r.configure do |config|
    # where to find the ymls
    config.locales_root = File.join(rails.root, 'config/locales/whatever')
    # where to write the generated ymls
    config.dump_location = File.join(rails.root, 'config/locales/whatever')
    # where to write the detected missing trabslations
    config.missing_translations_filename = File.join(Rails.root, 'config/locales/missing_translations.yml')

    # to http basic auth protect the editor. Otherwise, it's not available in production
    config.username = 'foo'
    config.password = 'bar'

    # What's the primary language? It's supposed to be complete, all other
    # languages are 'completed' to match the structure of this language
    config.primary_language = :de
    # Which languages are meant to be handled by I18nO7r
    config.languages = [:de, :en]

    # When detecting missing keys, ignore those matching this regexp
    config.ignore_missing_pattern = /simple_form\.((hints)|(placeholders)|(labels))/
    # ALTERNATIVELY: ignore those where this block returns true:
    config.ignore_missing_if do |key|
      key_is_ugly? key
    end
    # only save missing translations in this envs
    config.save_missing_translations_in_envs = %{development}
    # Prefix all detected missing translations with this string.
    # These value will be considered 'missing'
    config.missing_indicator = '[*]'

    # By default, we use the cdn versions of bootstrap and jquery to not have
    # explicit gem dependencies and keep this gem lean. If you prefer to use
    # other libs, enter them here.
    config.bootstrap_css_url = '//some.cdn.com/...'
    config.bootstrap_js_url = '//some.cdn.com/...'
    config.jquery_js_url = '//some.cdn.com/...'
  end
</pre>

Only `dump_location`, `locales_root`, `primary_language` and `languages` are required.

## Where are my ymls gone?

Whenever you interactively edit your translations at `localhost:3000/i18n_o7r/translations`, the pervious tree of ymls is moved to a timestamped directory like 'tmp/i18n_o7r/201503271257-saved-locales' in your app root.

## more info to come, this is pretty raw currently.

This project rocks and uses MIT-LICENSE.
