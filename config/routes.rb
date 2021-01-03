Rails.application.routes.draw do
  resources :sessions do
    get :word_count, path: 'word_count', on: :collection
    get :archive, path: 'archive', on: :collection
    get :header_actions, path: ':id/header-actions', on: :collection
  end

  root to: 'sessions#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
