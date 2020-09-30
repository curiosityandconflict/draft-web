Rails.application.routes.draw do
  resources :sessions do
    get :word_count, path: 'word_count', on: :collection
  end

  root to: 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
