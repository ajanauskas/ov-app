class Game < ActiveRecord::Base
  belongs_to :game_owners

  has_many :owners, through: :game_owners,
                    class_name: 'User',
                    foreign_key: 'user_id',
                    primary_key: 'game_id'

  has_many :levels, class_name: 'GameLevel', dependent: :destroy

  validates :title, presence: true, length: { in: 10..100 }
  validates :description, presence: true
  validates :start, presence: true

  scope :active, -> { where(active: true) }

  def self.create_with_game_owner(game, owner)
    ActiveRecord::Base.transaction do
      game.save!
      game_owner = GameOwner.new
      game_owner.user_id = owner.id
      game_owner.game_id = game.id
      game_owner.save!
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
