Rails.application.routes.draw do
  get 'my_jobs/index'
  get 'my_jobs/create'
  get 'my_jobs/show'
  get 'my_jobs/update'
  get 'my_jobs/destroy'
  get 'jobs/index'
  get 'jobs/create'
  get 'jobs/show'
  get 'jobs/update'
  get 'jobs/destroy'
  put '/update_password', to: 'passwords#update', as: :update_password
  post '/sign_up', to: 'registrations#create', as: :sign_up
  post '/sign_in', to: 'sessions#create', as: :sign_in
  delete '/logout', to: 'sessions#destroy', as: :logout
  # root "posts#index"
end
