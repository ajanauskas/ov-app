class Game < ActiveRecord::Base
  has_many :game_owners
  has_many :owners, through: :game_owners,
                    class_name: 'User',
                    foreign_key: 'user_id',
                    primary_key: 'game_id'
end
