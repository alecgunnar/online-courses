Rails.application.routes.draw do
  root 'assessment#index'

  get '/specs/:id', to: 'assessment#specs', as: :specs, constraints: {id: /\d+/}

  get '/submit', to: 'submissions#index', as: :submit
  post '/submit', to: 'submissions#create'

  get '/result/:id', to: 'submissions#view', as: :result, constraints: {id: /\d+/}

  get '/grade/:id', to: 'submissions#grade', as: :grade, constraints: {id: /\d+/}

  post '/launch', to: 'launch#verify'
  get '/launch/error', to: 'launch#error', as: :launch_error
end
