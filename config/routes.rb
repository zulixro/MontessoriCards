Rails.application.routes.draw do
  root 'categories#index'
  resources :cards do
    collection do
      get 'card_urls'
    end
  end
  resources :categories
end
