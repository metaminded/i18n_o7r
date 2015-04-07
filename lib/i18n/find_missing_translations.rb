if I18nO7r.save_missing_translations_in_envs.member?(Rails.env.to_s)

  module I18nO7r::FindMissingTranslations

    def lookup(locale, key, scope = [], options = {})
      show_missing = options.delete(:show_missing)
      t = super(locale, key, scope, options)
      if t
        # we found a proper match
        return t
      elsif !I18nO7r.missing_translations_filename || !I18nO7r.save_missing_translations_in_envs.member?(Rails.env.to_s)
        # we're not set up to do any special magic
        return nil
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
          a[e.to_s] ||= (i == keys.length-1) ? nil : {}
        end # keys each
      end # store transaction
      nil
    end # lookup
  end # FindMissingTranslations

  I18n::Backend::Simple.prepend I18nO7r::FindMissingTranslations
end
