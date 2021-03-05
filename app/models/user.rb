class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :invitations, -> { invited }, class_name: 'Membership', inverse_of: :user
  has_many :user_groups, through: :memberships
  has_many :predictions, dependent: :destroy

  before_validation :initialize_nickname
  before_save :set_tippkick_id

  validates :nickname, presence: true
  validates :nickname, uniqueness: true
  after_save :create_predictions!

  def membership_for(user_group)
    memberships.find_by(user_group: user_group)
  end

  private

  def create_predictions!
    Game.find_each do |game|
      Prediction.find_or_create_by(game: game, user: self)
    end
  end

  def initialize_nickname
    self.nickname = generate_id
  end

  def set_tippkick_id
    self.tippkick_id = generate_id
  end
end
