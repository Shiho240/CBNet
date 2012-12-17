class EncryptedPassword < ActiveRecord::Migration
  def up
  add_column :users, :encrypted_password, :string
  end

  def down
  remove_colmun :users, :encrypted_password, :string
  end
end
