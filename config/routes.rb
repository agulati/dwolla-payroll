DwollaPayroll::Application.routes.draw do

  post "login" => "users#login"
  match "dashboard" => "users#dashboard"

  match "dwolla_oauth_callback" => "callbacks#dwolla_oauth"

  root :to => "static#home"

end
