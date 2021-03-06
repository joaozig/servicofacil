Rails.application.routes.draw do

  devise_for :advertisers
  devise_for :users, controllers: { :sessions => "admin/sessions" }
  devise_scope :user do
    get 'admin/login', to: 'admin/sessions#new'
    get 'admin/logout', to: 'admin/sessions#destroy'
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    get 'dashboard', to: 'dashboard#index'
    get 'edit_profile', to: 'users#edit_profile'
    match 'update_profile', to: 'users#update_profile', via: [:patch, :put]
    resources :users
    resources :subcategories
    resources :categories
    resources :advertisers, only: [:index, :show, :edit, :update, :destroy]
  end

  namespace :advertisers do
    resources :ads
  end

  devise_scope :advertiser do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'cadastro', to: 'devise/registrations#new'
  end

  get 'sobre' => 'static_pages#about'
  get 'como-funciona' => 'static_pages#how_works'
  get 'contato' => 'static_pages#contact'
  get 'anuncios' => 'ads#index'
  root 'home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
