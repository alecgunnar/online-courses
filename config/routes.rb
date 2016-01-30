Rails.application.routes.draw do
  root 'overview#index'

  get '/grade', to: 'overview#grade', as: :grade

  get '/error', to: 'lti#error', as: :lti_error
  post '/hit', to: 'lti#verify'
end
