Rails.application.routes.draw do
  namespace :api do
    resources :features, only: [:index, :show] do
      member do
        post :comments, to: 'features#create_comment'
      end
    end
  end
end
