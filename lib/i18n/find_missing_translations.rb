if I18nO7r.save_missing_translations_in_envs.member? Rails.env.to_s

  module I18nO7r::FindMissingTranslations


    def lookup(locale, key, scope = [], options = {})
      t = super
      return t if t
      mt_store = YAML::Store.new(I18nO7r.missing_translations_filename)
      keys = I18n.normalize_keys(locale, key, scope, options[:separator])
      mt_store.transaction do
        keys.each.with_index.inject(mt_store) do |a, (e, i)|
          # puts ">> #{a} -> #{e}, #{i}"
          a[e.to_s] ||= (i == keys.length-1) ? "#{I18nO7r.missing_indicator} #{e.to_s.capitalize}" : {}
        end # keys each
      end # store transaction
    end # lookup
  end # FindMissingTranslations

  I18n::Backend::Simple.include I18nO7r::FindMissingTranslations

end
