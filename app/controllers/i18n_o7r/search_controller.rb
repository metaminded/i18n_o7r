module I18nO7r
  class SearchController < I18nO7r::ApplicationController

    def index
      @value = params[:query]
      redirect_to(request.referrer) && return if @value.length <= 3
      @store = Store.new
      @path = []
      @locals = []
      I18n.available_locales.each do |locale|
        vv = @store.for([], locale: locale)
        traverse_hash(vv)
      end
    end

    private

    def traverse_hash(hash)
      hash.each do |k,v|
        @path.push k
        if v.is_a?(Hash)
          # do the same thing
          traverse_hash(v)
        else
          if v =~ /#{@value}/i
            @locals << {key: @path[0...-1], entry: @path.last, value: v}
          end
        end
        @path.pop
      end
    end
  end
end
