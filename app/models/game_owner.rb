class GameOwner < ActiveRecord::Base
  belongs_to :game
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  belongs_to :team
end
