class AddCodeToGameLevel < ActiveRecord::Migration
  def change
    add_column :game_levels, :code, :string, null: false, length: 30, after: :description
  end

  def up
    GameLevel.destroy_all
  end
end
