class Game < ActiveRecord::Base
  belongs_to :game_owners

  has_many :owners, through: :game_owners,
                    class_name: 'User',
                    foreign_key: 'user_id',
                    primary_key: 'game_id'

  has_many :levels, class_name: 'GameLevel'

  validates :title, presence: true, length: { in: 10..100 }
  validates :description, presence: true
  validates :start, presence: true
end
