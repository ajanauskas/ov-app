class TeamInvitation < ActiveRecord::Base
  self.inheritance_column = nil

  INVITED_BY_TEAM    = 1
  INVITATION_REQUEST = 2

  scope :invitation_requests, -> { where(type: INVITATION_REQUEST) }
end
