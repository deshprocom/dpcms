Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'admin/dashboard#index'

  namespace :admin do
    resources :purchase_orders, only:[] do
      get '/attributes/edit', to: 'purchase_orders/attributes#edit'
      post '/attributes/update', to: 'purchase_orders/attributes#update'
    end
  end
end
