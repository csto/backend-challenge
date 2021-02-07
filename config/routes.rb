Rails.application.routes.draw do
  resources :members, only: [:new, :create, :index, :show] do
    resources :friendships, only: [:new, :create, :index]
  end

  root to: 'members#index'
end
