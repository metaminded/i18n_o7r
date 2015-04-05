module I18nO7r
  class MissingTranslationsController < ApplicationController

    def index
      @lang = params[:lang]
      @store = Store.new().unify!
    end

  end
end
