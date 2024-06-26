Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root "homes#top"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout
  get 'rules', to: 'homes#rules'
  get 'policy', to: 'homes#policy'
  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider

  resources :users, only: %i[new create]
  resources :posts, only: %i[index new create show edit update destroy] do
    resources :comments, only: %i[create edit destroy], shallow: true
    collection do
      get :bookmarks
      get :likes
      get :search_tag
    end
  end
  resource :profile, only: %i[show edit update]
  resources :bookmarks, only: %i[create destroy]
  resources :items, only: %i[new create destroy] do
    collection do
      get :select
    end
  end
  resources :likes, only: %i[create destroy]
  resources :password_resets, only: %i[new create edit update]
  resource :user_setting, only: %i[edit update]
end
