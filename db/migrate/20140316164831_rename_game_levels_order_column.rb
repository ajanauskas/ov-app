class RenameGameLevelsOrderColumn < ActiveRecord::Migration
  def change
    rename_column :game_levels, :order, :sort
  end
end
