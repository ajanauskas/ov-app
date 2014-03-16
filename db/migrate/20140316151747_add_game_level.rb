class AddGameLevel < ActiveRecord::Migration
  def change
    create_table :game_levels do |t|
      t.integer :game_id, null: false
      t.integer :order, size: 6, null: false
      t.string :description, null: false
    end

    add_index :game_levels, :game_id
  end
end
