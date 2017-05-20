Rails.application.routes.draw do
  root 'top#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "message" => 'comments#index'

  namespace :api, format: 'json' do
    namespace :v1  do
      resources :comments
    end
  end
end
