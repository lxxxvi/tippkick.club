class GameDecorator < SimpleDelegator
  include ActionView::Helpers::DateHelper

  def self.tournament_phase_colors
    {
      group: 'bg-gradient-to-r from-blue-100 to-blue-300 text-blue-900',
      round_of_16: 'bg-gradient-to-r from-yellow-100 to-yellow-300 text-yellow-900',
      quarter_finals: 'bg-gradient-to-r from-purple-100 to-purple-300 text-purple-900',
      semi_finals: 'bg-gradient-to-r from-pink-100 to-pink-300 text-pink-900',
      final: 'bg-gradient-to-r from-green-100 to-green-300 text-green-900'
    }
  end

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
