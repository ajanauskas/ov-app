class GameLevel < ActiveRecord::Base
  belongs_to :game

  has_many :game_level_prompts

  default_scope -> { order('sort ASC') }

  validates :sort, presence: true
  validates :description, presence: true
end
