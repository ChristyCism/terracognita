Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :potagers, only: [ :new, :create, :show] do
    resources :choices, only: [ :new, :create ]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
