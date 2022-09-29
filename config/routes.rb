Rails.application.routes.draw do
  resources :recipes, except: [:new, :edit]
  resources :authors, except: [:new, :edit]
end
