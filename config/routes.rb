Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'tours#home'

  resources :tourism_packages
  post 'tourism_packages/search', to: 'tourism_packages#search_packages', :defaults => { :format => 'js' }

  resources :bookings
  match 'my_bookings' => 'bookings#user_bookings', via: 'get'
end
