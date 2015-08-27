module I18nO7r
  class KeysController < I18nO7r::ApplicationController

    before_action :gsub_path, only: [:update, :destroy]

    def edit
      @path = params[:path]
      render action: 'edit', layout: false
    end

    def update
      @store = Store.new
      new_key = params[:new_key]
      if new_key.present?
        I18nO7r::languages.each do |l|
          append = ''
          if @keys.last =~ /~~\z/i
            append = '~~'
          end
          val = @store.for(@keys[0...-1], locale: l).delete @keys.last.to_sym
          @store.for(@keys[0...-1], locale: l)["#{params[:new_key]}#{append}".to_sym] = val
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
      I18nO7r::languages.each do |l|
        @store.for(@keys[0...-1], locale: l).delete @keys.last.to_sym
      end
      @store.dump!
      I18n.reload!
      redirect_to i18n_o7r.translations_path(params[:path].split('/')[0...-1].join('/'))
    end


    private

    def gsub_path
      @keys = (params[:path].try(:split, '/') || []).map{|s|s.gsub('--','/')}
    end
  end
end
