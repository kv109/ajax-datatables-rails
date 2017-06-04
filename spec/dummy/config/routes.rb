Rails.application.routes.draw do
  root 'welcome#index'
  resources :users do
    post 'datatable', on: :collection
  end
end
