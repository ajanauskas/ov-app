class GameLevel < ActiveRecord::Base
  belongs_to :game
  default_scope -> { order('sort ASC') }
end
