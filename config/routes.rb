Rails.application.routes.draw do
  resources :members, only: [:new, :create, :index, :show] do

  end

  root to: 'members#index'
end
