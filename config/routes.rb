StudioManager::Application.routes.draw do
  devise_for :views

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
    
    match '/studios/:studio_id/instructors(/:id)' => 'studios#instructors', :controller => 'studios', :action => 'studio_instructors', :via => [:get], :as => 'studio_instructors'

    match '/studios/:studio_id/students(/:id)' => 'studios#students', :controller => 'studios', :action => 'studio_students', :via => [:get], :as => 'studio_students'

    match '/studios/:studio_id/students(/:id)' => 'users#studio_students', :via => [:get]
    devise_for :users, :controllers => { :invitations => 'users/invitations' }

    resources :users do
        resources :accounts
    end 
    resources :plans
    
    resources :studios do
        resources :events
        resources :coupons
        resources :reports
        member do
            get 'details'
        end
    end
    

    match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

end