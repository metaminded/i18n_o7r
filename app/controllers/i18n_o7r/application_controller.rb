module I18nO7r
  class ApplicationController < ActionController::Base

    raise "Configure I18nO7r before use" unless I18nO7r.configured

    if I18nO7r.username.present? && I18nO7r.password.present?
      http_basic_authenticate_with name: I18nO7r.username, password: I18nO7r.password
    end

    before_filter do
      if (!I18nO7r.username || !I18nO7r.password) && Rails.env.production?
        raise "secure I18nO7r with username and password for use in production"
      end
    end

    def i18n_o7r_locales
      I18nO7r.languages.presence || I18n.available_locales
    end
  end
end
