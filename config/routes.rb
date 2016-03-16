Rails.application.routes.draw do
  root 'assessment#index'

  get '/assessment/create', to: 'assessments#new', as: :create_assessment
  post '/assessment/create', to: 'assessments#create'
  get '/assessment/edit', to: 'assessments#edit', as: :edit_assessment
  patch 'assessment/edit', to: 'assessments#update'

  get '/assessment/:id/specs', to: 'assessment#specs', as: :assessment_specs, constraints: { id: /\d+/ }

  get '/submission/upload', to: 'submissions#new', as: :upload_submission
  post '/submission/upload', to: 'submissions#upload'

  get '/submission/:id/result', to: 'submissions#view', as: :submission_results, constraints: { id: /\d+/ }

  get '/submission/:id/review', to: 'submissions#review', as: :submission_review, constraints: { id: /\d+/ }
  patch '/submission/:id/review', to: 'submissions#grade', constraints: { id: /\d+/ }

  get '/submission/:id/download', to: 'submissions#download', as: :download_submission, constraints: { id: /\d+/ }

  get '/driver/:id/download', to: 'test_driver#download', as: :download_driver, constraints: { id: /\d+/ }

  get '/driver/create', to: 'test_drivers#new', as: :create_test_driver
  post '/driver/create', to: 'test_drivers#create'
  
  get '/driver/:id/edit', to: 'test_drivers#edit', as: :edit_test_driver, constraints: {id: /\d+/}
  patch '/driver/:id/edit', to: 'test_drivers#update', constraints: {id: /\d+/}
  delete '/driver/:id/delete', to: 'test_drivers#delete', as: :delete_test_driver, constraints: {id: /\d+/}

  get '/result-file/:id/download', to: 'test_driver_result_files#download', as: :download_result_file, constraints: { id: /\d+/ }

  post '/launch', to: 'launch#verify'
  get '/launch/error', to: 'launch#error', as: :launch_error
end
