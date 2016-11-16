Rails.application.routes.draw do
  #get 'instructors/new'

  resources :instructors, :only => [:show, :new, :create]
  root :to => redirect('/instructors/new')

  #root 'instructors_views#instructor_views'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
