Rails.application.routes.draw do
  root 'student#index'

  get '/post-grade', to: 'student#grade'

  get '/manage', to: 'manage#index', as: :manage

  get '/error', to: 'lti#error', as: :lti_error
  
  post '/hit', to: 'lti#verify'
end
