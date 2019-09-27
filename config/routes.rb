Rails.application.routes.draw do
  root to: 'games#index'

  devise_for :players

  resources :games
  
  resources :player_participation, only: [:create, :destroy], param: :game
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
