Rails.application.routes.draw do

  root :to => 'sites#index'

  get ':id', to: 'sites#show', as: :site
  patch ':id', to: 'sites#update'
  delete ':id', to: 'sites#destroy'
  #HACK: siteじゃなくて固有のサイト名にしたい
  # get 'site/:id', to: 'products#show', as: :product 
  # patch 'site/:id', to: 'products#update', as: :product 

  get '/:id/tag_search/:tag_id', to: 'sites#tag_search', as: :tag_search
  
  resources :user_sessions
  resources :users
  scope 'user' do
    resources :sites
  end
  scope '/sites/:site_id' do
    resources :tags
  end

  scope ':site_id' do
    resources :products do      
      resources :product_tags, :as => :tags
    end
  end
  
  
  get 'user/login', to: 'user_sessions#new', :as => :login
  post 'user/logout', to: 'user_sessions#destroy', :as => :logout

end
