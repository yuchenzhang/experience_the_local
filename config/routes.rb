Rails.application.routes.draw do
  devise_for :travellers

  root "home#index"
end
