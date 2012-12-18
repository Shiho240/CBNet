class GameIndexing < ActiveRecord::Migration
  def up
  add_index :games, :user_id
  end

  def down
  end
end
