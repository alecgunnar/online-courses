Rails.application.routes.draw do
  root 'overview#index'

  get '/post-grade', to: 'overview#grade'

  get '/assessment/manage', to: 'instructor#index', as: :manage

  get '/error', to: 'lti#error', as: :lti_error
  post '/hit', to: 'lti#verify'
end
