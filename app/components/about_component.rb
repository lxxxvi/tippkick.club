class AboutComponent < ViewComponent::Base
  def open_source_credits_list_items
    [
      rdbms_credits,
      language_credits,
      application_credits,
      css_credits
    ].map(&method(:credits_to_links))
  end

  def credits_to_links(credits)
    credits.map(&method(:to_link)).to_sentence(last_word_connector: ' and ')
  end

  def to_link(row)
    name, path = row
    link_to name, path, class: 'link'
  end

  def rdbms_credits
    [['Postgres', 'https://www.postgresql.org/']]
  end

  def language_credits
    [['Ruby', 'https://www.ruby-lang.org/']]
  end

  def application_credits
    [
      ['Rails', 'https://rubyonrails.org/'],
      ['Puma', 'https://puma.io/'],
      ['Devise', 'https://github.com/heartcombo/devise'],
      ['Stimulus', 'https://stimulus.hotwire.dev/'],
      ['StimulusReflex', 'https://docs.stimulusreflex.com/'],
      ['the rest of the gang', 'https://github.com/lxxxvi/tippkick.club/blob/main/Gemfile']
    ]
  end

  def css_credits
    [['Tailwind CSS', 'https://tailwindcss.com/']]
  end
end
