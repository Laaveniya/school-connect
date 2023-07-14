Rails.application.routes.draw do

  root to: "welcome#index"
  get 'welcome/index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users
  resources :schools do
    get 'students', on: :member
  end
  resources :enrollments
  resources :course_batches
  resources :courses

  namespace :admin do
    resources :invitations, only: [:new, :create, :show]
  end
end
