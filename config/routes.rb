Rails.application.routes.draw do
  resources :users, only: [] do
    resource :points, only: [:show] do
      post :decrease
    end
  end
end
