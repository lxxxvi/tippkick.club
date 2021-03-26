class Team < ApplicationRecord
  validates :name, :invitation_token, presence: true
  validates :name, uniqueness: true

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  before_validation :initialize_invitation_token
  before_create :set_tippkick_id

  def membership_for(user)
    memberships.find_by(user: user)
  end

  def self.new_with_user(user, params)
    new(params).tap do |team|
      team.memberships.new(user: user, coach: true)
    end
  end

  def find_or_create_member(user)
    memberships.find_or_create_by(user: user)
  end

  def to_param
    tippkick_id
  end

  def decorate
    @decorate ||= TeamDecorator.new(self)
  end

  def self.global
    Team.find_by!(tippkick_id: :global)
  end

  private

  def set_tippkick_id
    self.tippkick_id = generate_id
  end

  def initialize_invitation_token
    self.invitation_token ||= generate_id(10)
  end
end
