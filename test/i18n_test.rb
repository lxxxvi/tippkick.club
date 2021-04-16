# frozen_string_literal: true

require 'i18n/tasks'

class I18nTest < ActiveSupport::TestCase
  def setup
    @i18n = I18n::Tasks::BaseTask.new
    @missing_keys = @i18n.missing_keys
    @unused_keys = @i18n.unused_keys
  end

  def test_no_missing_keys
    assert_empty @missing_keys,
                 "Missing #{@missing_keys.leaves.count} i18n keys, run `i18n-tasks missing' to show them"
  end

  def test_no_unused_keys
    assert_empty @unused_keys,
                 "#{@unused_keys.leaves.count} unused i18n keys, run `i18n-tasks unused' to show them"
  end

  def test_files_are_normalized
    skip if ENV['CI'].present? # skipped due different behaviour of libyaml

    non_normalized = @i18n.non_normalized_paths
    error_message = "The following files need to be normalized:\n" \
                    "#{non_normalized.map { |path| "  #{path}" }.join("\n")}\n" \
                    "Please run `i18n-tasks normalize' to fix"
    assert_empty non_normalized, error_message
  end

  def test_no_inconsistent_interpolations
    inconsistent_interpolations = @i18n.inconsistent_interpolations
    error_message = "#{inconsistent_interpolations.leaves.count} i18n keys have inconsistent interpolations.\n" \
                    "Please run `i18n-tasks check-consistent-interpolations' to show them"
    assert_empty inconsistent_interpolations, error_message
  end

  test '.available_locales_abbrevations' do
    I18n.with_locale :en do
      assert_equal({ 'de-CH': 'DE', en: 'EN' }, I18n.available_locales_abbrevations)
    end

    I18n.with_locale :'de-CH' do
      assert_equal({ 'de-CH': 'DE', en: 'EN' }, I18n.available_locales_abbrevations)
    end
  end

  test '.available_locales_fulls' do
    I18n.with_locale :en do
      assert_equal({ 'de-CH': 'German', en: 'English' }, I18n.available_locales_fulls)
    end

    I18n.with_locale :'de-CH' do
      assert_equal({ 'de-CH': 'Deutsch', en: 'Englisch' }, I18n.available_locales_fulls)
    end
  end
end
