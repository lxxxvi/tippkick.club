class ProfileForm
  include ActiveModel::Model

  delegate :persisted?, :to_param, to: :@object

  def initialize(object, params = {})
    @object = object
    @params = params
  end

  def nickname
    @params[:nickname] || @object.nickname
  end

  def save
    @object.update(@params) || copy_errors_and_false
  end

  def model_name
    ActiveModel::Name.new(self, nil, 'Profile')
  end

  private

  def copy_errors_and_false
    errors.copy!(@object.errors) && false
  end
end
