Rails.application.routes.draw do
  get 'search/search'
  get 'adminemails/create'
 
  get 'foods/index'
  get 'categories/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users 
  post '/auth/login', to: 'authentication#login'
 

  resources :categories
   resources :foods do
    collection do
      get 'search_food'
    end
  end

  resources :carts
  resources :line_items
  resources :orders do 
    member do
      post 'delay'
    end
  end
  
  get '/search', to: 'search#search'

  get 'reports/download_csv/:id', to: 'reports#download_csv', as: 'download_report'
  get '/reports/download_pdf', to: 'reports#download_pdf'


end
