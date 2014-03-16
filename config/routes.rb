OvApp::Application.routes.draw do
  root 'welcome#index'

  resources :users, only: [:new, :create] do
    collection do
      get :login, to: :login_form
      put :login, :logout
    end
  end

  resource :locale, only: [:update]
  resources :games do
    collection do
      get :my
    end
  end
end
