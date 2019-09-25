class Game < ApplicationRecord
  enum status: { pending: 0, in_progress: 1, finished: 2, archived: 3 }
  
  belongs_to :owner, class_name: "Player"
  
end
