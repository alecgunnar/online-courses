Rails.application.routes.draw do
  root 'overview#index'

  get '/notifications', to: 'notifications#index', as: 'notifications'
  get '/courses', to: 'courses#index', as: 'courses'
  get '/settings', to: 'settings#index', as: 'settings'

  devise_for :users, skip: [:registrations, :sessions]

  as :user do
    get '/sign-up', to: 'users/registrations#new', as: :new_user_registration
    post '/sign-up', to: 'users/registrations#create', as: :user_registration

    get '/sign-in', to: 'users/sessions#new', as: :new_user_session
    post '/sign-in', to: 'users/sessions#create', as: :user_session
    delete '/sign-out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
end
