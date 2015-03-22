Todo::Application.routes.draw do
  namespace :api do
    root 'users#index'

    post 'signup', to: 'users#create', as: 'signup'
    put 'update-account', to: 'users#update', as: 'update-account'
    delete 'cancel-account', to: 'users#destroy', as: 'cancel-account'

    resources :users, only: [:index, :show]

    resources :lists, except: [:new, :edit] do
      resources :items, only: :create
    end

    resources :items, only: :destroy
  end
end
