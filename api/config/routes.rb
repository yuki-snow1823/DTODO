Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    namespace :v1 do
      resources :todos, only: [:create, :destroy, :update]
      resources :rewards, only: [:create, :destroy, :update]
      resources :users, only: [:index, :create]
    get '/todos/:id', to: 'todos#complete'
    # todo達成用
  end
end
