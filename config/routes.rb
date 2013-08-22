StudioManager::Application.routes.draw do
  devise_for :views

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
  match '/users/:id/history' => 'users#history', :controller => 'users', :action => 'history', :via => [:get], :as => 'user_history'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
    
    match '/studios/:studio_id/instructors(/:id)' => 'studios#instructors', :controller => 'studios', :action => 'studio_instructors', :via => [:get], :as => 'studio_instructors'
    


    match '/studios/:studio_id/students(/:id)' => 'studios#students', :controller => 'studios', :action => 'studio_students', :via => [:get], :as => 'studio_students'

    devise_for :users, :controllers => { :invitations => 'users/invitations' }

    resources :users do
        resources :accounts
        resources :pictures
        member do
            get :registered_events, :attended_events, :purchases
        end
    end 
    resources :plans
    
    resources :studios do
        resources :events
        resources :memberships
        resources :customers
        resources :subscriptions
        resources :products
        resources :coupons
        resources :reports
    end
    

    match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

end