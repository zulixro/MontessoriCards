Rails.application.routes.draw do
  resources :cards do
    collection do
      get 'card_urls'
    end
  end
end
