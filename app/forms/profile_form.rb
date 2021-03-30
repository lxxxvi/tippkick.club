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

  def rooting_for_team
    @params[:rooting_for_team] || @object.rooting_for_team
  end

  def save
    @object.update(sanitized_params) || copy_errors_and_false
  end

  def model_name
    ActiveModel::Name.new(self, nil, 'Profile')
  end

  def sanitized_params
    {
      nickname: nickname,
      rooting_for_team: rooting_for_team
    }
  end

  def rooting_for_team_collection
    fifa_country_codes_as_options
  end

  def fifa_country_codes_as_options
    I18n.t('shared.fifa_country_codes').map(&:reverse)
  end

  private

  def copy_errors_and_false
    errors.copy!(@object.errors) && false
  end
end
