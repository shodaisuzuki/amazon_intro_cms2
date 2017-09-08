Rails.application.routes.draw do

  root :to => 'user_sessions#new'

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
    resources :sites , :except => [:index]
  end
  scope '/sites/:site_id' do
    resources :tags
  end

  scope ':site_id' do
    resources :products do      
      resources :product_tags, :as => :tags
    end
  end
  
  
  get 'users/login', to: 'user_sessions#new', :as => :login
  post 'users/logout', to: 'user_sessions#destroy', :as => :logout

end
