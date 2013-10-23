StudioManager::Application.routes.draw do

  devise_for :views
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
 
    #Check In Classes in Studio
   
    #Check In Classes in Studio
    match 'events/:event_id/checkin/' => 'events#checkin', :controller => 'events', :action => 'checkin', :via => [:get], :as => 'checkin'
    match 'events/:event_id/checkin/remote' => 'events#checkin_remote', :controller => 'events', :action => 'checkin_remote', :via => [:post], :as => 'checkin_remote'
    
    match 'memberships/:id/purchase/:profile_id' => 'memberships#purchase', :controller => 'memberships', :action => 'purchase', :via => [:get], :as => 'purchase_membership'
    
    #Studio and professional calendars
    match 'calendar(/:year(/:month))' => 'calendar#index', :as => 'calendar', :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
   # match 'users/:user_id/calendar(/:year(/:month))' => 'calendar#professional_index', :as => 'professional_calendar', :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
    
    #match '/studios/:id/create_for_client(/:user_id)' => 'customers#create_for_client', :controller => 'customers', :action => 'create_for_client', :via => [:post], :as => 'new_client_customer'
    #match '/studios/:id/new_customer' => 'customers#new_customer', :controller => 'customers', :action => 'new_customer', :via => [:get], :as => 'new_customer'
    match '/instructors/' => 'studios#instructors_database', :controller => 'studios', :action => 'instructors_database', :via => [:get], :as => 'instructors_database'

    #match '/studios/:studio_id/new_student/:event_id' => 'users#new_student', :controller => 'users', :action => 'new_student', :via => [:post], :as => 'new_student'
    #match '/login_new_student' => 'users#login_new_student', :controller => 'users', :action => 'login_new_student', :via => [:post], :as => 'login_new_student'

    # Managing adding and removing registration and cancelation by user
    match '/events/:id/cancel_registration/:profile_id' => 'events#cancel_registration', :controller => 'events', :action => 'cancel_registration', :via => [:get], :as => 'cancel_registration_event_user'
    match '/events/:id/remove_registration/:profile_id' => 'events#remove_registration', :controller => 'events', :action => 'remove_registration', :via => [:get], :as => 'remove_registration_event_user'
    match '/events/:id/checkin/:profile_id' => 'events#add_attendance', :controller => 'events', :action => 'add_attendance', :via => [:get], :as => 'add_attendance_event_user'

    
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
    get :index, :controller => "home", :action => "index"
    
    devise_scope :user do
        get '/auth/stripe_connect/callback', to: 'users/omniauth_callbacks#stripe_connect'
    end
    
    resources :profiles do
        resources :customers
    end
    # Testing out use of twilio, if not necessary delete
    resources :appointmentreminder do
        collection do
            post :makecall
        end
    end
    resources :pictures
    
    # Resources do not need to belong to user or studio, simplifying views and adding some authorization checks to controller
    resources :events do
        collection do 
            get :list
        end
        
        member do
            get :checkin  
            get :add_registration
            post :new_registration
            get :register
        end
    end
    
    # Currently other method is used to access products - simplify?
    resources :products
    resources :memberships
    resources :packages
    resources :charges
    resources :coupons
    resources :staff
    resources :students do
            collection do
            get :search
        end
    end
    resources :calendar

    resources :users do
        # Necessary to reduce complexity of view
        resources :roles do
            member do
                get :change_role, :controller => 'users', :action => 'change_role'
            end
        end
        resources :accounts
        
        collection do
            get :search
        end
        
        member do
            get :registered_events, :attended_events, :purchases
            get :students
            get :history
            get :set_map_view
        end
    end 
    
    resources :studios do
        resources :locations
        member do
            # get :instructors, :students
            # post :new_instructor
            # post :new_student
            get :_embed, :test
        end
    end

    get 'reports'        => 'reports#index'
    get 'reports#attendance'   => 'reports#attendance'
    get 'reports#revenue'   => 'reports#revenue'
  
    get 'settings/studio' => 'settings#studio'
    get 'settings/profile' => 'settings#profile'
    get 'settings/upgrade' => 'settings#upgrade'
    get 'settings/notifications' => 'settings#notifications'

    get 'support' => 'support#index'
    get 'support#start' => 'support#start'

end