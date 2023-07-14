Rails.application.routes.draw do
  resources :courses
  root to: "welcome#index"
  get 'welcome/index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users
  resources :schools

  namespace :admin do
    resources :invitations, only: [:new, :create, :show]
  end
end
