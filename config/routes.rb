DwollaPayroll::Application.routes.draw do
  get "user/create"

  get "user/edit"

  get "user/update"

  get "user/history"

  get "login/index"

  get "login/request_reset"

  get "login/reset"

  resources :user

  # The priority is based upon order of creation:
  # first created -> highest priority.
  post "login" => "users#login"
  match "dashboard" => "users#dashboard"

  match "dwolla_oauth_callback" => "callbacks#dwolla_oauth"

  root :to => "static#home"

end
