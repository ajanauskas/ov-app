class Team < ActiveRecord::Base
  has_many :team_members, dependent: :destroy
  has_many :members, through: :team_members,
                     source: :user

  belongs_to :owner, class_name: 'User'

  validates :name,
            presence: true,
            length: { minimum: 5, maximum: 40 },
            uniqueness: true

  after_create :add_owner_to_members

  def self.create_dummy_team_for(user)
    team = user.team || self.new

    return team unless team.new_record?

    team.name = "#{user.login} Team"
    team.owner = user
    team.save!
    team
  end

  def to_s
    name
  end

  private

  def add_owner_to_members
    team_member = team_members.build
    team_member.user_id = owner_id
    team_member.save!
  end
end
