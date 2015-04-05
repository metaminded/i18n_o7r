module I18nO7r
  class ApplicationController < ActionController::Base

    raise "Configure I18nO7r before use" unless I18nO7r.configured
    http_basic_authenticate_with name: I18nO7r.username, password: I18nO7r.password

  end
end
