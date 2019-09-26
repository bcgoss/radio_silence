class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :owned_games, class_name: "Game"
  has_many :player_participations
  has_many :games, through: :player_participations
  
  def to_s
    email
  end
  
end
