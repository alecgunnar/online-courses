Rails.application.routes.draw do
  root 'assessments#index'

  get '/assessment/create', to: 'assessments#new', as: :create_assessment
  post '/assessment/create', to: 'assessments#create'
  get '/assessment/edit', to: 'assessments#edit', as: :edit_assessment
  patch 'assessment/edit', to: 'assessments#update'
  get '/assessment/specs/:id', to: 'assessments#specs', as: :assessment_specs, constraints: {id: /\d+/}


  get '/submission/upload', to: 'submissions#index', as: :upload_submission
  post '/submission/upload', to: 'submissions#create'

  get '/submission/result/:id', to: 'submissions#view', as: :submission_results, constraints: {id: /\d+/}
  get '/submission/download/:id', to: 'submissions#download', as: :download_submission, constraints: {id: /\d+/}

  get '/submission/grade/:id', to: 'submissions#grade', as: :grade_submission, constraints: {id: /\d+/}

  get '/driver/download/:id', to: 'test_driver#download', as: :download_driver, constraints: {id: /\d+/}
  
  get '/driver/create', to: 'test_drivers#new', as: :create_test_driver
  post '/driver/create', to: 'test_drivers#create'
  
  get '/driver/edit/:id', to: 'test_drivers#edit', as: :edit_test_driver, constraints: {id: /\d+/}
  patch '/driver/edit/:id', to: 'test_drivers#update', constraints: {id: /\d+/}
  delete '/driver/delete/:id', to: 'test_drivers#delete', as: :delete_test_driver, constraints: {id: /\d+/}

  post '/launch', to: 'launch#verify'
  get '/launch/error', to: 'launch#error', as: :launch_error
end
