class AdjustUserTable < ActiveRecord::Migration
  def up
    change_column :users, :login, :string, limit: 20, null: false
    change_column :users, :email, :string, limit: 30, null: false
  end

  def down
    change_column :users, :login, :string, limit: 255, null: true
    change_column :users, :email, :string, limit: 255, null: true
  end
end
