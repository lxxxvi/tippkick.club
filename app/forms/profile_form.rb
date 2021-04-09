class ProfileForm
  include ActiveModel::Model

  delegate :persisted?, :to_param, to: :@object

  def initialize(object, redirect_to_path = nil, params = {})
    @object = object
    @redirect_to_path = redirect_to_path
    @params = params
  end

  def nickname
    @params[:nickname] || @object.nickname
  end

  def rooting_for_team
    @params[:rooting_for_team] || @object.rooting_for_team
  end

  def locale
    @params[:locale] || @object.locale
  end

  def redirect_to_path
    @redirect_to_path.presence
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
      rooting_for_team: rooting_for_team,
      locale: locale
    }
  end

  def rooting_for_team_collection
    GameDecorator.fifa_country_codes_as_options.map(&method(:to_rooting_for_team_option))
  end

  def locales_collection
    I18n.t('locales').map(&:reverse)
  end

  private

  def to_rooting_for_team_option(fifa_country_code_pair)
    name, fifa_country_code = fifa_country_code_pair
    emoji = FlagService.emoji(fifa_country_code)
    ["#{name} #{emoji}", fifa_country_code]
  end

  def copy_errors_and_false
    errors.copy!(@object.errors) && false
  end
end
