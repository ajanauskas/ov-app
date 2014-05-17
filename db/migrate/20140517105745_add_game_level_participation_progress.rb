class AddGameLevelParticipationProgress < ActiveRecord::Migration
  def change
    create_table :game_level_completions do |t|
      t.integer :team_id, null: false
      t.integer :game_level_id, null: false
      t.datetime :started_at, null: false
      t.datetime :finished_at, null: false
    end
  end
end
