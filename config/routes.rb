Rails.application.routes.draw do
  
  devise_for :users, 
  controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    invitations: "users/invitations"
  },
  path: '', 
  path_names: { sign_in: 'sign_in'}
  
  namespace :admin do 
    
    get 'dashboard', to: 'dashboard#index' # Ruta para el dashboard
    
    resources :users do
      resources :applications, only: [:index],
      controller: 'applications'
    end
    
    resources :joboffers
    resources :applications, only: %i[index show destroy] do
      member do
        patch :update_status
      end
    end
    
  end
  
  resources :users, only: [:show, :edit, :update] do
    resources :applications, only: [:index] 
  end
  
  
  resources :joboffers, only: [:index, :show] do
    resources :applications, only: [:create]
  end
  
  resources :applications, only: [:index, :create]

  # Defines the root path route ("/")  
  root "joboffers#index"
end
