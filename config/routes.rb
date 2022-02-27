Rails.application.routes.draw do
  get 'sessions/new'
  get '/',to:"tasks#index"
  namespace:admin do
    resources :users
  end
  resources  :tasks
  resources  :users, only: %i[new create show]
  resources :sessions, only: %i[new create destroy]
  
end
