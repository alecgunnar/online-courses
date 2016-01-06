Rails.application.routes.draw do
  root 'overview#index'

  get '/notifications', to: 'notifications#index', as: :notifications
  get '/courses', to: 'courses#index', as: :courses

  namespace :account do
    root to: 'settings#index'

    get '/api-auth', to: 'd2l#index', as: :api_auth
    get '/api-auth/go', to: 'd2l#forward', as: :api_forward_for_auth
    get '/api-auth/tokens', to: 'd2l#tokens', as: :api_tokens
  end

  devise_for :users, skip: [:registrations, :sessions, :passwords, :confirmation]

  devise_scope :user do
    get '/user/sign-up', to: 'users/registrations#new', as: :sign_up
    post '/user/sign-up', to: 'users/registrations#create'

    get '/user/sign-in', to: 'users/sessions#new', as: :sign_in
    post '/user/sign-in', to: 'users/sessions#create'
    delete '/user/sign-out', to: 'users/sessions#destroy', as: :sign_out

    get '/user/reset-password/request', to: 'users/passwords#new', as: :reset_password_request
    post '/user/reset-password/request', to: 'users/passwords#create'
    get '/user/reset-password', to: 'users/passwords#edit', as: :reset_password
    match '/user/reset-password', to: 'users/passwords#update', via: [:put, :patch]

    get '/user/confirmation/resend', to: 'users/confirmations#new', as: :resend_confirmation
    post '/user/confirmation/resend', to: 'users/confirmations#create'
    get '/user/confirmation', to: 'users/confirmations#show', as: :confirm_account
  end
end
