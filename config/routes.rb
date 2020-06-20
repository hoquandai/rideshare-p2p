Rails.application.routes.draw do

  root to: 'welcome#index'
  resources :trips, :except => [:new, :create]
  resources :drivers, :passengers, :except => [:destroy]
  resources :passengers do
    resources :trips, only: [:create]
  end

  patch '/drivers/:id/is_deactivated', to: 'drivers#is_deactivated', as:
  'mark_driver_deactivated'

  patch '/passengers/:id/mark_deactivate', to: 'passengers#mark_deactivate', as:
  'mark_passenger_deactivated'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
