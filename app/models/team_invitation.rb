class TeamInvitation < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :team
  belongs_to :user

  INVITED_BY_TEAM    = 1
  INVITATION_REQUEST = 2

  scope :requests_to_join, -> { where(type: INVITATION_REQUEST) }
  scope :invitations, -> { where(type: INVITED_BY_TEAM) }

  validates_uniqueness_of :user_id, scope: [:type, :team_id]

  def approve
    destroy
    TeamMember.where(user_id: user_id, team_id: team_id).first_or_create!
  end

  def reject
    destroy
  end
end
