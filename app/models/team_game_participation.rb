class TeamGameParticipation < ActiveRecord::Base
  belongs_to :team
  belongs_to :game
  belongs_to :game_level

  def self.create_participation_for(user: user, game: game)
    participation = find_by(team_id: user.team.id, game_id: game.id) || self.new

    return participation unless participation.new_record?

    participation.team = user.team
    participation.game = game
    participation.current_game_level_id = game.levels.first.id
    participation.save!

    participation
  end

  def current_game_level
    GameLevel.find_by_id(current_game_level_id)
  end
end
