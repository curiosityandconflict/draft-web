Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :user

  resources :stories do
    resources :writing_sessions do
      get :word_count, path: 'word_count', on: :collection
    end
    resource :outline, on: :member do
      resources :outline_items
    end
  end

  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
