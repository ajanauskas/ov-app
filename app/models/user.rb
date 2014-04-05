class User < ActiveRecord::Base
  has_secure_password
  validates_confirmation_of :password

  validates :login, :email, presence: true, uniqueness: true
  validates :password, :password_confirmation, length: { in: 6..20 }, presence: true, on: :create

  has_many :game_owners
  has_many :games, through: :game_owners,
                   class_name: 'Game',
                   foreign_key: 'game_id',
                   primary_key: 'user_id'

  belongs_to :team_members

  def team
    @team ||= team_members.first.team
  end
end
