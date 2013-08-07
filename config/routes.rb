StudioManager::Application.routes.draw do
  devise_for :views

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
    
    resources :users do
      resources :accounts
    end
    resources :plans
    resources :events

    match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
end