class UserGroup < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
end
