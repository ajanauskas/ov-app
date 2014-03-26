class GameLevelPrompt < ActiveRecord::Base
  belongs_to :game_level

  validates :appears_in, presence: true
  validates :description, presence: true

  default_scope -> { order('appears_in ASC') }
end
