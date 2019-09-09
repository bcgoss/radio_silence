class AddOwnerReferenceToGame < ActiveRecord::Migration[5.2]
  def change
    add_reference :games, :owner, index: true, foreign_key: false
    add_foreign_key :games, :players, column: :owner_id
  end
end
