Rails.application.routes.draw do
  root 'welcome#index'

  get '/manage', to: 'assessment#index', as: :manage
  get '/submit', to: 'submission#index', as: :submit

  post '/launch', to: 'launch#verify'
  get '/launch/error', to: 'launch#error', as: :launch_error
end
