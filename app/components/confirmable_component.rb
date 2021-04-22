class ConfirmableComponent < ViewComponent::Base
  renders_one :pre
  renders_one :cancel
  renders_one :proceed
end
