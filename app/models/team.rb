class Team < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  def membership_for(user)
    memberships.find_by(user: user)
  end

  def invite(user)
    memberships.find_or_create_by(user: user)
  end

  def self.create_with_user(user, team_name)
    create(name: team_name).tap do |team|
      membership = team.memberships.find_or_initialize_by(user: user)
      membership.admin = true
      membership.mark_accepted
      team.save
    end
  end
end
