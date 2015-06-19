I18nO7r::Engine.routes.draw do
  root to: 'translations#index'

  get  "translations/(*path)"  => 'translations#index', as: 'translations'
  post "translations/(*path)"  => 'translations#update'
  get "keys/(*path)/edit" => 'keys#edit', as: 'edit_key'
  patch "keys/(*path)" => 'keys#update', as: 'update_key'
  get "keys/(*path)" => 'keys#destroy', as: 'remove_key'
  get  "missing_translations/:lang/(*path)" => 'missing_translations#index', as: 'missing_translations'
  get "search" => 'search#index', as: 'search'
  get "markers" => 'markers#index', as: 'markers'
  post "mark/(*key)" => 'markers#create', as: 'mark'
  delete "unmark/(*key)" => 'markers#destroy', as: 'unmark'
end
