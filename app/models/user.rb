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

  has_many :team_members
  has_many :teams, through: :team_members,
                   source: :team

  def active_team
    team_members.where(active: true).first.try(:team)
  end

  def team
    return nil unless team_members.any?
    team_members.first.team
  end
end
