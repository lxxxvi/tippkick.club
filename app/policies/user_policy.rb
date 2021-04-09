class UserPolicy < ApplicationPolicy
  delegate :admin?, to: :record
end
