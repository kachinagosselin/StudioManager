StudioManager::Application.routes.draw do

  devise_for :views
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
    
    #Check In Classes in Studio
    match 'studios/:id/events/:event_id/checkin/' => 'studios#checkin_event', :controller => 'studios', :action => 'checkin_event', :via => [:get], :as => 'checkin_event'
    match 'studios/:id/events/:event_id/checkin_user' => 'studios#checkin_user', :controller => 'studios', :action => 'checkin_user', :via => [:post], :as => 'checkin_studio_user'
    match 'studios/:id/events/:event_id/checkin_user/:user_id' => 'studios#checkin_user_directly', :controller => 'studios', :action => 'checkin_user_directly', :via => [:post], :as => 'checkin_studio_user_directly'

    match 'studios/:id/checkin' => 'studios#checkin', :controller => 'studios', :action => 'checkin', :via => [:get], :as => 'checkin_studio'
    
    match 'studios/:id/invoice/:user_id' => 'studios#invoice', :controller => 'studios', :action => 'invoice', :via => [:get], :as => 'invoice'
    
    #Studio and professional calendars
    match 'studios/:studio_id/calendar(/:year(/:month))' => 'calendar#studio_index', :as => 'studio_calendar', :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
    match 'users/:user_id/calendar(/:year(/:month))' => 'calendar#professional_index', :as => 'professional_calendar', :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
    
    
    match '/users/:id/history' => 'users#history', :controller => 'users', :action => 'history', :via => [:post], :as => 'user_history'
    
    
    match '/studios/:id/create_for_client(/:user_id)' => 'customers#create_for_client', :controller => 'customers', :action => 'create_for_client', :via => [:post], :as => 'new_client_customer'
    match '/studios/:id/new_customer' => 'customers#new_customer', :controller => 'customers', :action => 'new_customer', :via => [:get], :as => 'new_customer'
    match '/instructors/' => 'studios#instructors_database', :controller => 'studios', :action => 'instructors_database', :via => [:get], :as => 'instructors_database'

    match '/studios/:studio_id/new_student/:event_id' => 'users#new_student', :controller => 'users', :action => 'new_student', :via => [:post], :as => 'new_student'

    match '/login_new_student' => 'users#login_new_student', :controller => 'users', :action => 'login_new_student', :via => [:post], :as => 'login_new_student'

    
    
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
    
    devise_scope :user do
        get '/auth/stripe_connect/callback', to: 'customers#register'
    end
    
    resources :profiles
    
    resources :users do
        resources :accounts
        resources :customers
        resources :profiles
        resources :pictures
        resources :events
        resources :memberships
        resources :packages
        resources :charges
        resources :coupons
        
        collection do
            post :search
        end
        
        member do
            get :registered_events, :attended_events, :purchases
            get :dashboard
            get :students
            get :products, :controller => 'products', :action => 'professional_index'
        end
    end 
    resources :plans
    
    resources :studios do
        resources :locations
        resources :events
        resources :memberships
        resources :packages
        resources :coupons
        resources :reports
        collection do
        end
        member do
            get :instructors, :students
            post :new_instructor
            post :new_studente
            get :widget
            get :products, :controller => 'products', :action => 'studio_index'
        end
    end
    
end