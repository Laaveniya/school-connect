Rails.application.routes.draw do

  root to: "welcome#index"
  get 'welcome/index'
  devise_for :users, controllers: { registrations: 'registrations', invitations: 'admin/invitations' }
  resources :users
  resources :schools do
    get 'students', on: :member
  end
  resources :enrollments
  resources :course_batches
  resources :courses
  get '/dashboard', to: 'students#dashboard'
  post '/enroll_course_batch', to: 'students#enroll_course_batch'
end
