StudioManager::Application.routes.draw do
  devise_for :views

    match 'studios/:studio_id/register' => 'studios#register', :controller => 'studios', :action => 'register', :via => [:get]
    match 'studios/:studio_id/invoice' => 'studios#invoice', :controller => 'studios', :action => 'invoice', :via => [:get]
    match 'studios/:studio_id/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
    match '/users/:id/history' => 'users#history', :controller => 'users', :action => 'history', :via => [:get], :as => 'user_history'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }


    devise_for :users, :controllers => { :invitations => 'users/invitations' }

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