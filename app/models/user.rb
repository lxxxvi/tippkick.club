class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_save :create_predictions!

  private

  def create_predictions!
    Game.find_each do |game|
      Prediction.find_or_create_by(game: game, user: self)
    end
  end
end
