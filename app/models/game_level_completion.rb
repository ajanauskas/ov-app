class GameLevelCompletion < ActiveRecord::Base
  belongs_to :team
  belongs_to :game_level
end
