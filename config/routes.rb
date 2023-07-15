Rails.application.routes.draw do
  root to: "welcome#index"
  devise_for :users, controllers: { registrations: 'registrations', invitations: 'admin/invitations' }
  authenticated :user, ->(user) { user.admin? || user.school_admin? } do
    get 'welcome/index'
    resources :users, except: [:new, :create]
    resources :schools do
      get 'students', on: :member
    end
    resources :enrollments
    resources :course_batches
    resources :courses
  end

  authenticated :user, ->(user) { user.student? } do
    get '/dashboard', to: 'students#dashboard'
    post '/enroll_course_batch', to: 'students#enroll_course_batch'
  end
end
