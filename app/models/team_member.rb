class TeamMember < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :team_id

  before_create :enforce_single_active_team
  after_save :enforce_single_active_team, if: :active_changed?

  def activate!
    self.active = true
    save!
  end

  def inactivate!
    self.active = false
    save!
  end

  private

  def enforce_single_active_team
    if active?
      TeamMember
        .where('id <> ?', id)
        .where(user_id: user_id, active: true)
        .update_all(active: false)
    elsif !TeamMember.where(user_id: user_id, active: true).exists?
      self.active = true
    end
  end
end
