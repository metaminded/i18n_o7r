module I18nO7r
  class TranslationsController < I18nO7r::ApplicationController

    before_action do
      @keys = (params[:path].try(:split, '/') || []).map{|s|s.gsub('--','/')}
      @store = Store.new()
    end

    def index
      vv = @store.unify!.for(@keys)
      if vv.present?
        vv = vv.group_by{|k,v| v.is_a?(Hash) && v.present? && (v.keys - [:html]).present? }
        @subtrees = vv[true] || []
        @entries = vv[false] || []
      end
    end

    def update
      @store.unify!
      params[:translations].each do |_, translation|
        translation.each do |lang, locale|
          lstore = @store.for(locale[:key].split('.'), locale: lang)
          if !lstore
            puts "Ignoring: #{locale[:key]}"
          else
            locale[:entry].each do |k, v|
              lstore[k.to_sym] = v.presence
            end
          end
        end
      end
      @store.dump!
      I18n.reload!
      redirect_to params[:return_path] || i18n_o7r.translations_path(params[:path])
    end
  end
end
