I18nO7r::Engine.routes.draw do
  get  "translations/(*path)"  => 'translations#index', as: 'translations'
  post "translations/(*path)"  => 'translations#update'
  get  "missing_translations/:lang/(*path)" => 'missing_translations#index', as: 'missing_translations'
end
