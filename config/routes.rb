Rails.application.routes.draw do
  namespace :v1 do
    resources :users
    resources :companies
    resources :jobs
    resources :messages
    resources :conversations

    post "auth/sign_in", to: "authentication#sign_in"
    post "auth/sign_up", to: "authentication#sign_up"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
