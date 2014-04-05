class AddTeamRelatedTables < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :owner_id, null: false
      t.string :name, length: 50, null: false
      t.timestamps
    end

    add_index :teams, :owner_id

    create_table :team_members do |t|
      t.integer :team_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end

    add_index :team_members, [:user_id, :team_id]
    add_index :team_members, [:team_id]

    create_table :team_game_participations do |t|
      t.integer :team_id, null: false
      t.integer :game_id, null: false
      t.integer :current_game_level_id, null: false
      t.timestamps
    end
  end
end
