Rails.application.routes.draw do
  resources :recipes, except: [:new, :edit]
end
