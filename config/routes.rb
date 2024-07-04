Rails.application.routes.draw do
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'

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

    get 'videos/id/:id' => 'youtube_videos#get_by_id'
    get 'videos' => 'youtube_videos#index'
    get 'videos/latest' => 'youtube_videos#latest_video'

    post 'videos/create' => 'youtube_videos#create'
    post 'videos/watch' => 'youtube_videos#watched'

    get 'notifications' => 'notification#fetch'
    post 'notifications/read' => 'notification#read'
    post 'notifications/read-all' => 'notification#read_all'
  end

  # Defines the root path route ("/")
  root "home#index"
  get '/*path' => 'home#index'
end
