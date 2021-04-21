# Permitted locales available for the application
# I18n.available_locales = [:en, :de]

# Set default locale to something other than :en
# I18n.default_locale = :de

module I18n
  def self.root_locale
    I18n.locale.to_s.split('-').first
  end

  def self.available_locales_abbrevations
    available_locales_for(:abbreviation)
  end

  def self.available_locales_fulls
    available_locales_for(:full)
  end

  def self.available_locales_for(locale_type)
    I18n.t('locales').each_with_object({}) do |item, hash|
      locale_key, locale_values = item
      abbreviation_value = locale_values[locale_type]

      hash[locale_key] = abbreviation_value
    end
  end
end
