module I18nO7r
  class KeysController < I18nO7r::ApplicationController

    def edit
      @path = params[:path]
      render action: 'edit', layout: false
    end

    def update
      @store = Store.new
      @keys = params[:path].try(:split, '/') || []
      new_key = params[:new_key]
      if new_key.present?
        I18n.available_locales.each do |l|
          val = @store.for(@keys[0...-1], locale: l).delete @keys.last.to_sym
          @store.for(@keys[0...-1], locale: l)[params[:new_key].to_sym] = val
        end
        @store.dump!
        I18n.reload!
        render json: {success: true}
      else
        render json: {success: false}, status: :unprocessable_entity
      end
    end

    def destroy
      @store = Store.new
      @keys = params[:key].try(:split, '/') || []
      I18n.available_locales.each do |l|
        @store.for(@keys[0...-1], locale: l).delete @keys.last.to_sym
      end
      @store.dump!
      I18n.reload!
      redirect_to i18n_o7r.translations_path(@keys[0...-1].join('/'))
    end
  end
end
