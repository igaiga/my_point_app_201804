Rails.application.routes.draw do
  resources :users, only: [] do
    resource :points, only: [:show] do
      post :decrease
      post :increase
    end
  end
end
