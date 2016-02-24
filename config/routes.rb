Rails.application.routes.draw do
  root 'welcome#index'

  get '/manage', to: 'manage#index', as: :manage
  get '/assessment', to: 'assessment#index', as: :assessment

  post '/launch', to: 'launch#verify'
  get '/launch/error', to: 'launch#error', as: :launch_error
end
