if I18nO7r.save_missing_translations_in_envs.member?(Rails.env.to_s)
  module I18nO7r::FindMissingTranslations

    def lookup(locale, key, scope = [], options = {})
      show_missing = options.delete(:show_missing)
      replace_all = !options.delete(:ignore_replace) && I18nO7r.replace_all_with.presence
      defaults = options.delete(:defaults) || {}
      I18nO7r.requested_keys << [scope, key].join('.') unless options.delete(:dont_collect_requested_keys)
      t = super(locale, key, scope, options) || super(locale, "#{key}~~", scope, options)
      if t
        # we found a proper match
        return t unless replace_all
        return replace_existing(t, replace_all)
      elsif !I18nO7r.missing_translations_filename || !I18nO7r.save_missing_translations_in_envs.member?(Rails.env.to_s)
        # we're not set up to do any special magic
        return defaults[locale]
      end
      # The key wasn't found and we're prepared to write it away
      ipat = I18nO7r.ignore_missing_pattern
      kk = [locale, scope, key].join('.')
      case ipat
      when Regexp then return nil if ipat.match(kk)
      when Proc then return nil if ipat.(kk)
      end
      mt_store = YAML::Store.new(I18nO7r.missing_translations_filename)
      keys = I18n.normalize_keys(locale, key, scope, options[:separator])
      mt_store.transaction do
        keys.each.with_index.inject(mt_store) do |a, (e, i)|
          # puts ">> #{a} -> #{e}, #{i}"
          a[e.to_s] ||= (i == keys.length-1) ? defaults[locale] : {}
        end # keys each
      end # store transaction
      return defaults[locale]
    end # lookup

    private

    def replace_existing(obj, with)
      case obj
      when String then with
      when Array then  obj.map{|x| replace_existing(x, with)}
      when Hash then   Hash[obj.map{|k,v| [k, replace_existing(v, with)]}]
      else obj
      end
    end

  end # FindMissingTranslations

  I18n::Backend::Simple.send :prepend, I18nO7r::FindMissingTranslations
else

  module I18nO7r::FindMissingTranslationsLight
    def lookup(locale, key, scope = [], options = {})
      super(locale, key, scope, options) || super(locale, "#{key}~~", scope, options)
    end
  end

  I18n::Backend::Simple.send :prepend, I18nO7r::FindMissingTranslationsLight
end
