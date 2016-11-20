Rails.application.routes.draw do
  get 'instructor/instructor_view' => 'instructor#instructor_view'
  #get 'instructor/instructor_view', to: 'instructor#instructor_view'

  resources :instructors, :students, :projects, :enrollments, :sections
  #root :to => redirect('/instructor/instructor_view.html.erb')

  #root 'instructor#instructor_view'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
