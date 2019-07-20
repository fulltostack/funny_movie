Rails.application.routes.draw do
  root to: 'pages#index'
  resources :sessions, only: [:create]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :youtube_videos, only: :create
  get 'share', to: 'youtube_videos#new', as: :share
  post 'vote', to: 'youtube_video_votes#vote', as: :vote
end
