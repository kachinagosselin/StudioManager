StudioManager::Application.routes.draw do
  devise_for :views
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

    match 'studios/:id/events/:event_id/checkin/' => 'studios#checkin_event', :controller => 'studios', :action => 'checkin_event', :via => [:get], :as => 'checkin_event'
    match 'studios/:id/events/:event_id/checkin_user' => 'studios#checkin_user', :controller => 'studios', :action => 'checkin_user', :via => [:post], :as => 'checkin_studio_user'
    match 'studios/:id/checkin' => 'studios#checkin', :controller => 'studios', :action => 'checkin', :via => [:get], :as => 'checkin_studio'
    match 'studios/:id/invoice' => 'studios#invoice', :controller => 'studios', :action => 'invoice', :via => [:get]
    match 'studios/:studio_id/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
    match '/users/:id/history' => 'users#history', :controller => 'users', :action => 'history', :via => [:get], :as => 'user_history'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
    
    devise_scope :user do
        get '/auth/stripe_connect/callback', to: 'customer#register'
    end

    resources :users do
        resources :accounts
        resources :customers
        resources :profiles
        resources :pictures
        member do
            get :registered_events, :attended_events, :purchases
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
        end
    end
    
end