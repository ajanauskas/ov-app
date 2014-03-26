class GameLevel < ActiveRecord::Base
  belongs_to :game

  has_many :prompts, class_name: 'GameLevelPrompt', dependent: :destroy

  default_scope -> { order('sort ASC') }

  validates :sort, presence: true
  validates :description, presence: true
  validates :code, presence: true
end
