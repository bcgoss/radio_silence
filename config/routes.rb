Rails.application.routes.draw do
  resources :games
  devise_for :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'games#index'
end
