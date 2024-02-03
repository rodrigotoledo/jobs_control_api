Rails.application.routes.draw do
  resources :jobs do
    collection do
      get 'applications'
      get 'applieds'
    end

    member do
      post 'apply'

      post 'apply_user/:user_id', to: 'jobs#apply_user'
      delete 'unapply_user/:user_id', to: 'jobs#unapply_user'
    end
  end
  post 'sign_up', to: 'registrations#create', as: :sign_up
  post 'sign_in', to: 'sessions#create', as: :sign_in
  put 'update_password', to: 'passwords#update', as: :update_password
  delete 'logout', to: 'sessions#destroy', as: :logout
end
