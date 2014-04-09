class TeamGameParticipation < ActiveRecord::Base
  belongs_to :team
  belongs_to :game
  belongs_to :current_game_level, class_name: 'GameLevel'

  def self.create_participation_for(user: user, game: game)
    participation = find_by(team_id: user.team.id, game_id: game.id) || self.new

    return participation unless participation.new_record?

    participation.team = user.team
    participation.game = game
    participation.current_game_level = game.levels.first
    participation.save!

    participation
  end

  def current_game_level
    GameLevel.find_by_id(current_game_level_id)
  end

  def can_advance_level?
    game.levels.where('sort > ?', current_game_level.sort).any?
  end

  def advance_level!
    new_level = game.levels.where('sort > ?', current_game_level.sort).first
    touch(:updated_at)
    self.current_game_level = new_level
    save!
  end
end
