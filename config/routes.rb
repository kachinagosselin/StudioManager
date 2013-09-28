StudioManager::Application.routes.draw do

  devise_for :views
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
    
    #Check In Classes in Studio
    match 'studios/:id/events/:event_id/checkin/' => 'studios#checkin_event', :controller => 'studios', :action => 'checkin_event', :via => [:get], :as => 'checkin_event'
    match 'studios/:id/events/:event_id/checkin_user' => 'studios#checkin_user', :controller => 'studios', :action => 'checkin_user', :via => [:post], :as => 'checkin_studio_user'
    match 'studios/:id/events/:event_id/checkin_user/:user_id' => 'studios#checkin_user_directly', :controller => 'studios', :action => 'checkin_user_directly', :via => [:post], :as => 'checkin_studio_user_directly'
    
    match 'studios/:id/invoice/:user_id' => 'studios#invoice', :controller => 'studios', :action => 'invoice', :via => [:get], :as => 'invoice'
    
    #Studio and professional calendars
    match 'studios/:studio_id/calendar(/:year(/:month))' => 'calendar#studio_index', :as => 'studio_calendar', :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
    match 'users/:user_id/calendar(/:year(/:month))' => 'calendar#professional_index', :as => 'professional_calendar', :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
    
    match '/studios/:id/create_for_client(/:user_id)' => 'customers#create_for_client', :controller => 'customers', :action => 'create_for_client', :via => [:post], :as => 'new_client_customer'
    match '/studios/:id/new_customer' => 'customers#new_customer', :controller => 'customers', :action => 'new_customer', :via => [:get], :as => 'new_customer'
    match '/instructors/' => 'studios#instructors_database', :controller => 'studios', :action => 'instructors_database', :via => [:get], :as => 'instructors_database'

    match '/studios/:studio_id/new_student/:event_id' => 'users#new_student', :controller => 'users', :action => 'new_student', :via => [:post], :as => 'new_student'

    match '/login_new_student' => 'users#login_new_student', :controller => 'users', :action => 'login_new_student', :via => [:post], :as => 'login_new_student'

    match 'studios/:studio_id/events/:id/cancel_registration/:profile_id' => 'events#cancel_registration', :controller => 'events', :action => 'cancel_registration', :via => [:get], :as => 'cancel_registration_studio_event_user'
    match 'studios/:studio_id/events/:id/remove_registration/:profile_id' => 'events#remove_registration', :controller => 'events', :action => 'remove_registration', :via => [:get], :as => 'remove_registration_studio_event_user'
    match 'studios/:studio_id/events/:id/checkin/:profile_id' => 'events#add_attendance', :controller => 'events', :action => 'add_attendance', :via => [:get], :as => 'add_attendance_studio_event_user'

    
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
        resources :events do
            member do
                get :checkin
            end
        end
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
            get :history
            get :products, :controller => 'products', :action => 'professional_index'
        end
    end 
    resources :plans
    
    resources :studios do
        resources :locations
        resources :memberships
        resources :packages
        resources :coupons
        resources :reports
        resources :events do
            member do
                get :checkin  
                get :add_registration
                #For users without an account with our software
                post :new_registration
            end
        end
        
        collection do
        end
        
        member do
            get :instructors, :students
            post :new_instructor
            post :new_student
            get :_embed_calendar, :test
            get :products, :controller => 'products', :action => 'studio_index'
        end
    end
    
end