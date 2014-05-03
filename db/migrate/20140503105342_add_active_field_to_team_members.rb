class AddActiveFieldToTeamMembers < ActiveRecord::Migration
  def change
    add_column :team_members, :active, :boolean, after: :user_id, default: false
  end
end
