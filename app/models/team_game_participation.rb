class TeamGameParticipation < ActiveRecord::Base
  belongs_to :team
  belongs_to :game
  belongs_to :game_level

  def self.create_dummy_participation_for(user: user, team: team)
  end
end
