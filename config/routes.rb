Rails.application.routes.draw do
  root 'overview#index'

  get '/notifications', to: 'notifications#index', as: 'notifications'
  get '/courses', to: 'courses#index', as: 'courses'
  get '/account', to: 'settings#index', as: 'settings'

  devise_for :users, skip: [:registrations, :sessions, :passwords, :confirmation]

  devise_scope :user do
    get '/account/sign-up', to: 'users/registrations#new', as: :sign_up
    post '/account/sign-up', to: 'users/registrations#create'

    get '/account/sign-in', to: 'users/sessions#new', as: :sign_in
    post '/account/sign-in', to: 'users/sessions#create'
    delete '/account/sign-out', to: 'users/sessions#destroy', as: :sign_out

    get '/account/reset-password/request', to: 'users/passwords#new', as: :reset_password_request
    post '/account/reset-password/request', to: 'users/passwords#create'
    get '/account/reset-password', to: 'users/passwords#edit', as: :reset_password
    match '/account/reset-password', to: 'users/passwords#update', via: [:put, :patch]

    get '/account/confirmation/resend', to: 'users/confirmations#new', as: :resend_confirmation
    post '/account/confirmation/resend', to: 'users/confirmations#create'
    get '/account/confirmation', to: 'users/confirmations#show', as: :confirm_account
  end
end
