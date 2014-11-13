class CreateGames < ActiveRecord::Migration
  def change
    create_table  :games do |t|
      t.integer  :player1_id
      t.integer  :player2_id
      t.integer  :winner_id
      t.integer  :loser_id

      t.timestamps
    end
  end
end
