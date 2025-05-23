Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  resources :villages do
    collection { get :search }
    collection { post :upload }
    resources :duplicates
  end
  resources :census_villages do
    collection { post :upload }
  end 
  resources :orders do
    collection { post :compare }
    collection { post :report }
  end

  root 'villages#search'
end
