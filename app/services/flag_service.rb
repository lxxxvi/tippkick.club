class FlagService
  EMOJI_MAPPING = {
    aut: '🇦🇹',
    bel: '🇧🇪',
    cro: '🇭🇷',
    cze: '🇨🇿',
    den: '🇩🇰',
    eng: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
    esp: '🇪🇸',
    fin: '🇫🇮',
    fra: '🇫🇷',
    ger: '🇩🇪',
    hun: '🇭🇺',
    ita: '🇮🇹',
    mkd: '🇲🇰',
    ned: '🇳🇱',
    pol: '🇵🇱',
    por: '🇵🇹',
    rus: '🇷🇺',
    sco: '🏴󠁧󠁢󠁳󠁣󠁴󠁿',
    sui: '🇨🇭',
    svk: '🇸🇰',
    swe: '🇸🇪',
    tur: '🇹🇷',
    ukr: '🇺🇦',
    wal: '🏴󠁧󠁢󠁷󠁬󠁳󠁿'
  }.freeze

  def self.emoji(fifa_country_code)
    EMOJI_MAPPING[fifa_country_code&.downcase&.to_sym]
  end
end
