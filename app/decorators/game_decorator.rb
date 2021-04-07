class GameDecorator < SimpleDelegator
  include ActionView::Helpers::DateHelper

  def self.flag_path(team_name)
    "/images/flags/#{team_name&.downcase}.svg"
  end

  def display_uefa_game_id
    I18n.t('shared.uefa_game_id', uefa_game_id: uefa_game_id)
  end

  def display_kickoff_at_from_now
    distance_of_time_in_words(kickoff_at, Time.zone.now)
  end

  def display_venue
    Game.human_enum_name(:venue, venue)
  end

  def display_home_team_name
    display_team_name(home_team_name)
  end

  def display_guest_team_name
    display_team_name(guest_team_name)
  end

  private

  def display_team_name(team_name)
    return if team_name.nil?

    I18n.t("shared.fifa_country_codes.#{team_name.upcase}")
  end
end
