OvApp::Application.routes.draw do
  root 'welcome#index'

  resources :users, only: [:new, :create] do
    collection do
      get :login, to: :login_form
      put :login
    end
  end

  resource :locale, only: [:update]
end
