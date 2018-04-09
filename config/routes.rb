Rails.application.routes.draw do
  resources :users, only: [] do
    resource :points, only: [:show] do
      get :decrease #TODO: POSTへ変更
    end
  end
end
