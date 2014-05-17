class Team < ActiveRecord::Base
  has_many :team_members, dependent: :destroy
  has_many :members, through: :team_members,
                     source: :user
  has_many :team_invitations, dependent: :destroy

  has_many :game_participations, class_name: 'TeamGameParticipation'

  belongs_to :owner, class_name: 'User'

  validates :name,
            presence: true,
            length: { minimum: 5, maximum: 40 },
            uniqueness: true

  after_create :add_owner_to_members

  def to_s
    name
  end

  def request_to_join!(user)
    team_invitations.requests_to_join.where(user_id: user.id).first_or_create!
  end

  def invite_to_join!(user)
    team_invitations.invitations.where(user_id: user.id).first_or_create!
  end

  private

  def add_owner_to_members
    team_member = team_members.build
    team_member.active = true
    team_member.user_id = owner_id
    team_member.save!
  end
end
