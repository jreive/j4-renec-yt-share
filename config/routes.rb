Rails.application.routes.draw do

  devise_for :users,
             path: '', skip: [:sessions, :registrations,
              :passwords, :confirmations,
              :unlocks]
  devise_scope :user do
    post 'login', to: 'users/sessions#create'
    delete 'logout', to: 'users/sessions#destroy'
    post 'signup', to: 'users/registrations#create'
  end

  namespace :api do
    post 'user/validate' => 'user#validate'
    post 'user/check' => 'user#check'
  end

  # Defines the root path route ("/")
  root "home#index"
  get '/*path' => 'homepage#index'
end
