class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :home_team_score, :guest_team_score, :points,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            allow_nil: true
end
