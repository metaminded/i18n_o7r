class I18nO7r::Engine < ::Rails::Engine
  isolate_namespace I18nO7r
  initializer "i18n_o7r.assets.precompile" do |app|
    app.config.assets.precompile += %w[i18n_o7r_manifest]
  end
end
