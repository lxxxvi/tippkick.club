require 'test_helper'

class AboutComponentTest < ViewComponent::TestCase
  test '#render' do
    component = AboutComponent.new

    assert_equal expected_open_source_credits_list_items, component.open_source_credits_list_items
  end

  private

  # rubocop:disable Layout/LineLength
  def expected_open_source_credits_list_items
    [
      '<a class="link" href="https://www.postgresql.org/">Postgres</a>',
      '<a class="link" href="https://www.ruby-lang.org/">Ruby</a>',
      '<a class="link" href="https://rubyonrails.org/">Rails</a>, <a class="link" href="https://puma.io/">Puma</a>, <a class="link" href="https://github.com/heartcombo/devise">Devise</a>, <a class="link" href="https://stimulus.hotwire.dev/">Stimulus</a>, <a class="link" href="https://docs.stimulusreflex.com/">StimulusReflex</a> and <a class="link" href="https://github.com/lxxxvi/tippkick.club/blob/main/Gemfile">the rest of the gang</a>',
      '<a class="link" href="https://tailwindcss.com/">Tailwind CSS</a>'
    ]
  end
  # rubocop:enable Layout/LineLength
end
