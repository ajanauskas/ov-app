OvApp::Application.routes.draw do
  root 'welcome#index'

  resources :users
  resource :locale, only: [:update]
end
