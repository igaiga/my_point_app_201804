Rails.application.routes.draw do
  resources :users, only: [] do
    resources :points, only: [:index]
  end
end
