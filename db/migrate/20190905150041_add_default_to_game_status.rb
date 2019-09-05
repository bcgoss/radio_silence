class AddDefaultToGameStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_null :games, :status, false
    change_column_default :games, :status, from: nil, to: 0
  end
end
