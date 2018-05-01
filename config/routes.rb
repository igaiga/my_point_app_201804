Rails.application.routes.draw do
  get "swagger", to: "swagger#index"
  mount SwaggerUiEngine::Engine, at: "/swagger-ui"

  resources :users, only: [] do
    resource :points, only: [:show] do
      post :decrease
      post :increase
    end
  end
end
