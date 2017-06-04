Rails.application.routes.draw do
  root 'welcome#index'
  resources :posts
  resources :users do
    post 'datatable', on: :collection
  end
end
