class Team < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  before_save :set_tippkick_id

  def membership_for(user)
    memberships.find_by(user: user)
  end

  def invite(user)
    memberships.find_or_create_by(user: user)
  end

  def self.new_with_user(user, params)
    new(params).tap do |team|
      membership = team.memberships.new(user: user)
      membership.admin = true
      membership.mark_accepted
    end
  end

  def to_param
    tippkick_id
  end

  private

  def set_tippkick_id
    self.tippkick_id = generate_id
  end
end
