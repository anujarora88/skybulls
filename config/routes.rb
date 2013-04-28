SkybullsRails::Application.routes.draw do

  resources :user_leagues

  namespace :users do
    get 'cashier' => 'cashier#index', :as => :cashier
    post 'deposit' => 'cashier#deposit', :as => :deposit
    post 'withdrawl' => 'cashier#withdrawl', :as => :withdrawl
    get 'preapproval_success' => 'cashier#preapproval_success', :as => :preapproval_success
    get 'preapproval_failure' => 'cashier#preapproval_failure', :as => :preapproval_failure
    post 'league_registration_info' =>'league_registration#show_league_info', :as=> :league_info
    post 'league_registration_register' =>'league_registration#register', :as=> :league_register
    post 'update_user_info' =>'profile#update_user_info', :as=> :update_user
    post 'stock_list' =>'league_registration#search_stocks', :as=> :search_stocks
  end

  resources :leagues, :only => [:index, :show] do
    member do
      post 'subscribe'
      post 'unsubscribe'
    end
    match "/buy/:id" => "leagues/trades#buy"
    match "/sell/:id" => "leagues/trades#sell"
    resources :dashboard, :controller => 'leagues/dashboard', :only => [:index] do
      collection do
        get 'search'
      end
    end

  end

=begin
  resources :leagues do
    collection do
      get :add_users
      post :save_users
    end
  end
=end

  namespace :admin do
    resources :leagues do
      collection do
        get :add_users
        post :save_users
      end
    end
  end

    get 'admin' => 'admin/dashboard#index'



  devise_for :admin_users

  devise_for :users, :skip => [:sessions], :controllers => {:omniauth_callbacks => "authentications"}
  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session

  end

  get 'dashboard' => 'dashboard#index', :as => :dashboard


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
