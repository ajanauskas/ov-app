OvApp::Application.routes.draw do
  root 'games#index'

  resources :users, only: [:index, :show, :new, :create] do
    collection do
      get :login, to: :login_form
      put :login, :logout
    end
  end

  resource :locale, only: [:update]

  namespace :me, as: :my do
    resources :games do
      resources :levels, controller: 'game_levels' do
        resources :prompts, controller: 'game_level_prompts'
      end
    end
  end

  resources :games, only: [:index] do
    resource :team_game_participation,
             controller: 'game_participations',
             path: '/play',
             only: [:show, :update],
             as: :participation
  end
end
