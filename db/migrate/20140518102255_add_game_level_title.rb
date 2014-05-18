class AddGameLevelTitle < ActiveRecord::Migration
  def change
    add_column :game_levels, :title, :string, length: 100, null: false, after: :sort
  end
end
