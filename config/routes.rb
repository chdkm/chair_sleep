Rails.application.routes.draw do
  root "homes#top"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  resources :users, only: %i[new create]
  resources :posts, only: %i[index new create show edit update destroy] do
    resources :comments, only: %i[create edit destroy], shallow: true
    collection do
      get :bookmarks
      get :search_tag
    end
  end
  resource :profile, only: %i[show edit update]
  resources :bookmarks, only: %i[create destroy]
end
