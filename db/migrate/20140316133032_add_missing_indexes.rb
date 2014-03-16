class AddMissingIndexes < ActiveRecord::Migration
  def change
    execute('TRUNCATE users')

    add_index :users, :login, unique: true
    add_index :users, :email, unique: true

    add_index :game_owners, :user_id
    add_index :game_owners, :game_id
    add_index :game_owners, [:user_id, :game_id], unique: true
  end
end
