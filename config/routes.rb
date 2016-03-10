Rails.application.routes.draw do
  root 'welcome#index'

  get '/manage', to: 'assessment#index', as: :manage
  get '/submit', to: 'submission#index', as: :submit

  post '/launch', to: 'launch#verify'
  get '/launch/error', to: 'launch#error', as: :launch_error
  
  get '/submission/index', to: 'submission#index'
  post '/submission/create', to: 'submission#create'
  get '/submission/destroy', to: 'submission#destroy'
end
