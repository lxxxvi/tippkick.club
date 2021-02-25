class UserGroup < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  def membership_for(user)
    memberships.find_by(user: user)
  end

  def self.create_with_user(user, user_group_name)
    create(name: user_group_name).tap do |user_group|
      membership = user_group.memberships.find_or_initialize_by(user: user)
      membership.admin = true
      membership.mark_accepted
      user_group.save
    end
  end
end
