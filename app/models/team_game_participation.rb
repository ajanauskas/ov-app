class TeamGameParticipation < ActiveRecord::Base
  belongs_to :team
  belongs_to :game
  belongs_to :game_level

  def self.create_participation_for(user: user, game: game)
    participation = find_by(team: user.team, game: game) || self.new

    return participation unless participation.new_record?

    participation.team = team
    participation.game = game
    participation.game_level = game.levels.first
    participation.save!

    participation
  end
end
