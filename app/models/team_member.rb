class TeamMember < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :team_id

  after_update :enforce_single_active_team, if: :active_changed?

  def activate_user!
    self.active = true
    save!
  end

  private

  def enforce_single_active_team
    if active?
      TeamMember
        .where('id <> ?', id)
        .where(user_id: user_id, team_id: team_id, active: true)
        .update_all(active: false)
    end
  end
end
