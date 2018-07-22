Rails.application.routes.draw do
  namespace :v1 do
    resources :users
    resources :companies
    resources :jobs
    resources :messages
    resources :conversations

    post "auth/sign_in", to: "authentication#sign_in"
    post "auth/sign_up", to: "authentication#sign_up"
    post "auth/forgot_password", to: "authentication#forgot_password"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
