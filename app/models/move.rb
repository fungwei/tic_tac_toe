class Move < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :round
end
