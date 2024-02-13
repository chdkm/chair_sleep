Rails.application.routes.draw do
  root "homes#top"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy', as: :logout

  resources :users, only: %i[new create]
  resources :posts, only: %i[index]
end
