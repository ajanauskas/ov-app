class GameLevel < ActiveRecord::Base
  belongs_to :game

  has_many :prompts, class_name: 'GameLevelPrompt'

  default_scope -> { order('sort ASC') }

  validates :sort, presence: true
  validates :description, presence: true
end
