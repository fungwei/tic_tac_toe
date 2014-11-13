class Game < ActiveRecord::Base
  # Remember to create a migration!
  has_many :moves
  belongs_to :winner, class_name: "User", foreign_key: "winner_id"
  belongs_to :loser, class_name: "User", foreign_key: "loser_id"
  belongs_to :player1, class_name: "User", foreign_key: "player1_id"
  belongs_to :player2, class_name: "User", foreign_key: "player2_id"
end
