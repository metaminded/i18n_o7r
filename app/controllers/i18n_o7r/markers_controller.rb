module I18nO7r
  class MarkersController < I18nO7r::ApplicationController

    before_action :gsub_path, only: [:create, :destroy]

    def create
      @store = Store.new
      I18n.available_locales.each do |l|
        @store.for(@keys[0...-1], locale: l)["#{@keys.last}~~".to_sym] = @store.for(@keys[0...-1], locale: l)[@keys.last.to_sym]
        @store.for(@keys[0...-1], locale: l).delete @keys.last.to_sym
      end
      @store.dump!
      I18n.reload!
      render json: {success: true}
    end

    def index
      @store = Store.new
      @path = []
      @locals = []
      vv = @store.for([], locale: I18n.default_locale)
      traverse_hash(vv)
    end

    def destroy
      @store = Store.new
      I18n.available_locales.each do |l|
        @store.for(@keys[0...-1], locale: l)["#{@keys.last}".gsub(/~~\z/, '').to_sym] = @store.for(@keys[0...-1], locale: l)[@keys.last.to_sym]
        @store.for(@keys[0...-1], locale: l).delete @keys.last.to_sym
      end
      @store.dump!
      I18n.reload!
      render json: {success: true}
    end


    private

    def traverse_hash(hash)
      hash.each do |k,v|
        @path.push k
        if v.is_a?(Hash)
          # do the same thing
          traverse_hash(v)
        else
          if k =~ /~~\z/i
            @locals << {key: @path[0...-1], entry: @path.last, value: v}
          end
        end
        @path.pop
      end
    end

    def gsub_path
      @keys = (params[:key].try(:split, '/') || []).map{|s|s.gsub('--','/')}
    end
  end
end
