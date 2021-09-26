Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :user
  
  resources :writing_sessions do
    get :word_count, path: 'word_count', on: :collection
    get :archive, path: 'archive', on: :collection
    get :header_actions, path: ':id/header_actions', on: :collection
  end

  resources :stories, only: [:index, :new, :create, :update, :destroy]
  

  root to: 'writing_sessions#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
