Rails.application.routes.draw do
  
  put 'administrator/update_user/:user_id', to: 'users/administrator#update_user' , as: 'administrator_update_user'
  get 'administrator/edit_user/:user_id', to: 'users/administrator#edit_user' , as: 'administrator_edit_user'
  get 'administrator', to: 'users/administrator#index'

  get 'pages/index' , to: 'home#index'
  get 'pages/terms'
  get 'pages/terms_modal' , to: 'pages#terms_modal'

  get 'style_guide' ,:to => "style_guide#index" , :as => "styleguide"
  get 'style_guide/typography' ,:to => "style_guide#typography", :as => "styleguide_typography"
  get 'style_guide/panels' ,:to => "style_guide#panels", :as => "styleguide_panels"
  get 'style_guide/tabs' ,:to => "style_guide#tabs", :as => "styleguide_tabs"
  get 'style_guide/messages' ,:to => "style_guide#messages", :as => "styleguide_messages"
  get 'style_guide/tables' ,:to => "style_guide#tables", :as => "styleguide_tables"
  get 'style_guide/buttons' ,:to => "style_guide#buttons", :as => "styleguide_buttons"
  get 'style_guide/forms' ,:to => "style_guide#forms", :as => "styleguide_forms"
  
  get 'home/index'

  root to: 'home#index'
  
  devise_for :users, controllers: {
   sessions: 'users/sessions',
   registrations: 'users/registrations',
   passwords: 'users/passwords',
   confirmations: 'users/confirmations'
  }
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
