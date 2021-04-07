require 'test_helper'

class FlagServiceTest < ActiveSupport::TestCase
  test '#emoji' do
    assert_equal '🇦🇹', FlagService.emoji(:aut)
    assert_equal '🇧🇪', FlagService.emoji(:bel)
    assert_equal '🇭🇷', FlagService.emoji(:cro)
    assert_equal '🇨🇿', FlagService.emoji(:cze)
    assert_equal '🇩🇰', FlagService.emoji(:den)
    assert_equal '🏴󠁧󠁢󠁥󠁮󠁧󠁿', FlagService.emoji(:eng)
    assert_equal '🇪🇸', FlagService.emoji(:esp)
    assert_equal '🇫🇮', FlagService.emoji(:fin)
    assert_equal '🇫🇷', FlagService.emoji(:fra)
    assert_equal '🇩🇪', FlagService.emoji(:ger)
    assert_equal '🇭🇺', FlagService.emoji(:hun)
    assert_equal '🇮🇹', FlagService.emoji(:ita)
    assert_equal '🇲🇰', FlagService.emoji(:mkd)
    assert_equal '🇳🇱', FlagService.emoji(:ned)
    assert_equal '🇵🇱', FlagService.emoji(:pol)
    assert_equal '🇵🇹', FlagService.emoji(:por)
    assert_equal '🇷🇺', FlagService.emoji(:rus)
    assert_equal '🏴󠁧󠁢󠁳󠁣󠁴󠁿', FlagService.emoji(:sco)
    assert_equal '🇨🇭', FlagService.emoji(:sui)
    assert_equal '🇸🇰', FlagService.emoji(:svk)
    assert_equal '🇸🇪', FlagService.emoji(:swe)
    assert_equal '🇹🇷', FlagService.emoji(:tur)
    assert_equal '🇺🇦', FlagService.emoji(:ukr)
    assert_equal '🏴󠁧󠁢󠁷󠁬󠁳󠁿', FlagService.emoji(:wal)
  end
end
