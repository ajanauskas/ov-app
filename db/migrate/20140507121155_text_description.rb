class TextDescription < ActiveRecord::Migration
  def up
    change_column :game_levels, :description, :text, null: false
  end
end
