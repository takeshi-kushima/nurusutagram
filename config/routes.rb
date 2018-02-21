Rails.application.routes.draw do
  resources :contacts
  get 'sessions/new'

  root to:'tops#show'
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  resources :tops
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :blogs do
    collection do
      post :confirm
    end
  end
  
end
