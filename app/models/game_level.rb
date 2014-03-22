class GameLevel < ActiveRecord::Base
  belongs_to :game
  default_scope -> { order('sort ASC') }

  validates :sort, presence: true
  validates :description, presence: true
end
