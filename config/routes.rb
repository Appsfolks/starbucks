Starbucks::Application.routes.draw do

  get "events/index"

  get "events/new"

  get "events/show"

  get "comments/new"

  get "comments/index"

  get "posts/index"
  
  
  match '/users/:user_id/connect' => "users#connect", :user_id=>"%{user_id}",:constraints=>{:user_id=>/[a-zA-Z0-9]+/}
  
 match '/users/:user_id/accept' => "users#accept", :user_id=>"%{user_id}",:constraints=>{:user_id=>/[a-zA-Z0-9]+/}
 
 match '/users/:user_id/disconnect' => "users#disconnect", :user_id=>"%{user_id}",:constraints=>{:user_id=>/[a-zA-Z0-9]+/}
  
  match '/users/:user_id/comments/:id/delete' => "comments#deletecomment", :user_id=>"%{user_id}", :id=>"%{id}",:constraints=>{:user_id=>/[a-zA-Z0-9]+/}

  match '/users/:user_id/comments/:id/likecomment' => "comments#likecomment", :user_id=>"%{user_id}", :id=>"%{id}", :constraints=>{:user_id=>/[a-zA-Z0-9]+/ }
  
  match '/users/:user_id/posts/:id/likepost' => "posts#likepost", :user_id=>"%{user_id}", :id=>"%{id}", :constraints=>{:user_id=>/[a-zA-Z0-9]+/ }
  
  match '/users/:user_id/posts/:id/morecomments' => "posts#morecomments", :user_id=>"%{user_id}", :id=>"%{id}", :constraints=>{:user_id=>/[a-zA-Z0-9]+/ }
  

 match 'authenticate' => 'sessions#create'
 
 match 'login' => 'sessions#new', :as =>'login'
 
 match 'fbsignin'=> 'sessions#fbsignin', :as => 'fbsignin'
 
 match 'logout' => 'sessions#signout', :as=>'logout'
 
 
 match "/users/:user_id/posts/:id" => redirect("/users/%{user_id}/posts")
 
 match "/users/:user_id/profile" => "profiles#show", :user_id=>"%{user_id}", :constraints=>{:user_id=>/[a-zA-Z0-9]+/ }
 
 match "/users/:user_id/profile/edit" => "profiles#edit", :user_id=>"%{user_id}", :constraints=>{:user_id=>/[a-zA-Z0-9]+/ }, :as=>'profile_edit'
 
  resources :users
  
  resources :profiles
  
  resources :sessions
  
  resources :posts
  
  resources :comments
  
  resources :events
  
  resources :users do
    resources :profiles
  end
  
  resources :users do
    resources :posts
  end
  
  resources :posts do
    resources :comments
  end
  
 root :to => "users#index"
    

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
 #match 'photos/:id' => 'photos#show', :id => /[A-Z]\d{5}/
end
