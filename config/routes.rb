Rails.application.routes.draw do
  resources :campaigns, except: [:show, :edit, :update]
  resources :messages, except: [:edit, :update, :destroy] do
    collection do
      get 'detect_suppressions'
      get 'emails'
    end
  end

  root 'messages#index'
end
