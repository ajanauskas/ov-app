class GameLevelPrompt < ActiveRecord::Base
  belongs_to :game_level

  validates :appears_in, presence: true
  validates :description, presence: true

  default_scope -> { order('appears_in ASC') }

  def visible_for?(game_participation)
    game_participation.updated_at + appears_in.minutes < Time.now
  end

  def appears_at(game_participation)
    return Time.now if visible_for?(game_participation)
    game_participation.updated_at + appears_in.minutes
  end
end
