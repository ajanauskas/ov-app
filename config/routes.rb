OvApp::Application.routes.draw do
  root 'games#index'

  resources :users, only: [:new, :create] do
    collection do
      get :login, to: :login_form
      put :login, :logout
    end
  end

  resource :locale, only: [:update]
  resources :games do
    resource :team_game_participation,
             controller: 'game_participations',
             path: '/play',
             only: [:show, :update],
             as: :participation

    collection do
      get :my
    end

    resources :levels, controller: 'game_levels' do
      resources :prompts, controller: 'game_level_prompts'
    end
  end
end
