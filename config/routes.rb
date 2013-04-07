DwollaPayroll::Application.routes.draw do

  match "home" => "users#home"
  post "login" => "users#login"
  match "dashboard" => "users#dashboard"

  match "dwolla_oauth_callback" => "callbacks#dwolla_oauth"

  root :to => "users#home"

end
