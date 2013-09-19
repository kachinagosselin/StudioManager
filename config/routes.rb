StudioManager::Application.routes.draw do
  devise_for :views
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
    
    #Check In Classes in Studio
    match 'studios/:id/events/:event_id/checkin/' => 'studios#checkin_event', :controller => 'studios', :action => 'checkin_event', :via => [:get], :as => 'checkin_event'
    match 'studios/:id/events/:event_id/checkin_user' => 'studios#checkin_user', :controller => 'studios', :action => 'checkin_user', :via => [:post], :as => 'checkin_studio_user'
    match 'studios/:id/checkin' => 'studios#checkin', :controller => 'studios', :action => 'checkin', :via => [:get], :as => 'checkin_studio'
    
    match 'studios/:id/invoice/:user_id' => 'studios#invoice', :controller => 'studios', :action => 'invoice', :via => [:get], :as => 'invoice'
    
    #Studio and professional calendars
    match 'studios/:studio_id/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
    match 'users/:user_id/calendar(/:year(/:month))' => 'calendar#professional', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}, :as => 'private_calendar'
    
    match '/users/:id/history' => 'users#history', :controller => 'users', :action => 'history', :via => [:get], :as => 'user_history'
    
    
    match '/studios/:id/create_for_client(/:user_id)' => 'customers#create_for_client', :controller => 'customers', :action => 'create_for_client', :via => [:post], :as => 'new_client_customer'
    match '/studios/:id/new_customer' => 'customers#new_customer', :controller => 'customers', :action => 'new_customer', :via => [:get], :as => 'new_customer'
    match '/instructors/' => 'studios#instructors_database', :controller => 'studios', :action => 'instructors_database', :via => [:get], :as => 'instructors_database'

    match '/studios/:studio_id/new_student/:event_id' => 'users#new_student', :controller => 'users', :action => 'new_student', :via => [:post], :as => 'new_student'

    
    
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
    
    devise_scope :user do
        get '/auth/stripe_connect/callback', to: 'customers#register'
    end

    resources :users do
        resources :accounts
        resources :customers
        resources :profiles
        resources :pictures
        member do
            get :registered_events, :attended_events, :purchases
            get :private_dashboard, :as => 'private_dashboard'
            get :private_students, :as => 'private_students'
            get :private_memberships, :as => 'private_memberships'
            get :private_coupons, :as => 'private_coupons'
        end
    end 
    resources :plans
    
    resources :studios do
        resources :events
        resources :memberships
        resources :subscriptions
        resources :products
        resources :coupons
        resources :reports
        member do
            get :instructors, :students
            get :widget
        end
    end
    
end