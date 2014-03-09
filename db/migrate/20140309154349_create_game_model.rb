class CreateGameModel < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title, limit: 100, null: false
      t.text :description, null: false
      t.datetime :start
      t.boolean :active
      t.timestamps
    end

    create_table :game_owners do |t|
      t.integer :game_id, null: false
      t.integer :user_id, null: false
    end
  end
end
