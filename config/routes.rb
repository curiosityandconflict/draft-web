Rails.application.routes.draw do
  resources :sessions do
    get :word_count, path: 'word_count', on: :collection
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
