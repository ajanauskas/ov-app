class GameLevelCompletion < ActiveRecord::Base
  belongs_to :team
  belongs_to :game_level

  def completed_in
    finished_at - started_at
  end
end
