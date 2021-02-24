class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :user_group

  validates :user_id, uniqueness: { scope: :user_group_id }
end
