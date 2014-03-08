OvApp::Application.routes.draw do
  root 'welcome#index'

  resources :users
end
