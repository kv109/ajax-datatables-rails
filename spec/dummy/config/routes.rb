Rails.application.routes.draw do
  root 'welcome#index'

  resources :posts do
    post 'datatable', on: :collection
  end

  resources :users do
    post 'datatable', on: :collection
  end
end
