class GameLevel < ActiveRecord::Base
  belongs_to :game

  has_many :prompts, class_name: 'GameLevelPrompt', dependent: :destroy
  has_many :completions, class_name: 'GameLevelCompletion'

  default_scope -> { order('sort ASC') }

  validates :sort, :description, :code, :title, presence: true
end
