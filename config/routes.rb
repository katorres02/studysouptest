Rails.application.routes.draw do
  resources :webhooks, except: [:new, :show, :edit, :update]
  resources :campaigns, except: [:show, :edit, :update]
  resources :messages, except: [:show, :edit, :update, :destroy] do
    collection do
      get 'detect_suppressions'
      get 'emails'
    end
  end

  root 'messages#index'
end
