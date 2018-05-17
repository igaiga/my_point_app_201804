Rails.application.routes.draw do
  get "swagger", to: "swagger#index"
  mount SwaggerUiEngine::Engine, at: "/swagger-ui"

  resources :users, only: [] do
  #resources :users, param: :token, only: [] do # /users/:user_token/...にする
    resource :points, only: [:show] do
      post :decrease
      post :increase
    end
  end
end
