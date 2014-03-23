class CreateGamePrompts < ActiveRecord::Migration
  def change
    create_table :game_level_prompts do |t|
      t.integer :game_level_id, null: false
      t.text :description, null: false
      t.integer :appears_in, null: false
    end
  end
end
