Rails.application.routes.draw do
  namespace :scrum do
    resources :iterations
    resources :user_stories do
      resources :acs
    end
  end
end
