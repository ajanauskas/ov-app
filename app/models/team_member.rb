class TeamMember < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  def activate_user!
    previous_active_team = TeamMember.find_by(user_id: user_id, team_id: team_id, active: true)

    return if previous_active_team == self

    ActiveRecord::Base.transaction do
      self.active = true
      self.save!

      if previous_active_team.present?
        previous_active_team.active = false
        previous_active_team.save!
      end
    end
  end
end
