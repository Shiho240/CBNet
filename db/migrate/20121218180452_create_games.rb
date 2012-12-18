class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :gamename
      t.string :genre
      t.integer :rating
      t.text :game_desc
      t.text :review
      t.integer :user_id

      t.timestamps
    end
  end
end
