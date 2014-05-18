class TeamGameParticipation < ActiveRecord::Base
  belongs_to :team
  belongs_to :game
  belongs_to :current_game_level, class_name: 'GameLevel'

  def self.create_participation_for(user: user, game: game)
    participation = find_by(team_id: user.active_team.id, game_id: game.id) || self.new

    return participation unless participation.new_record?

    participation.team = user.active_team
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
    mark_level_complete!(updated_at, Time.now)
    touch(:updated_at)
    self.current_game_level = new_level
    save!
  end

  private

  def mark_level_complete!(started_at, finished_at)
    progress = GameLevelCompletion.new
    progress.team_id = self.team_id
    progress.game_level_id = self.current_game_level_id
    progress.started_at = started_at
    progress.finished_at = finished_at
    progress.save!
  end
end
