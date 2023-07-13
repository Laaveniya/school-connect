Rails.application.routes.draw do
  root to: "welcome#index"
  get 'welcome/index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users
  resources :schools
end
