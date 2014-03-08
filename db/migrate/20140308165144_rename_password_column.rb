class RenamePasswordColumn < ActiveRecord::Migration
  def change
    rename_column :users, :crypted_password, :password_digest
  end
end
