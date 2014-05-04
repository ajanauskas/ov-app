class AddTeamInvitation < ActiveRecord::Migration
  def change
    create_table :team_invitations do |t|
      t.integer :user_id, null: false
      t.integer :team_id, null: false
      t.integer :type, null: false
      t.timestamps
    end
  end
end
