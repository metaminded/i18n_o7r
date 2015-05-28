I18nO7r::Engine.routes.draw do
  get  "translations/(*path)"  => 'translations#index', as: 'translations'
  post "translations/(*path)"  => 'translations#update'
  get "keys/(*path)/edit" => 'keys#edit', as: 'edit_key'
  patch "keys/(*path)" => 'keys#update', as: 'update_key'
  get "keys/(*key)" => 'keys#destroy', as: 'remove_key'
  get  "missing_translations/:lang/(*path)" => 'missing_translations#index', as: 'missing_translations'
  get "search" => 'search#index', as: 'search'
end
