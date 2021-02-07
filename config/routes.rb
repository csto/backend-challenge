Rails.application.routes.draw do
  get 'experts/index'
  resources :members, only: [:new, :create, :index, :show] do
    resources :friendships, only: [:new, :create, :index]
    resources :experts, only: [:index] do
      collection do
        get :connections
      end
    end
  end

  root to: 'members#index'
end
