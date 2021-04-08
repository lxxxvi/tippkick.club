require 'i18n/tasks/scanners/file_scanner'

# https://github.com/glebm/i18n-tasks/issues/321
class ScanActiveRecordsErrors < I18n::Tasks::Scanners::FileScanner
  include I18n::Tasks::Scanners::OccurrenceFromPosition

  # @return [Array<[absolute key, Results::Occurrence]>]
  def scan_file(path)
    text = read_file(path)
    text.scan(/^\s*errors.add(?:\():(\w*), (?:I18n.t\(){0,1}(?::){0,1}(?:"){0,1}([^"\r\n),]*)/).map do |type, message|
      attribute_or_message = if type == 'base'
                               'messages'
                             else
                               "attributes.#{type}"
                             end
      occurrence = occurrence_from_position(
        path, text, Regexp.last_match.offset(0).first
      )
      model = File.basename(path, '.rb') # .split('/').last
      # p "================"
      # p type
      # p message
      # p ["activerecord.errors.models.%s.%s.%s" % [model, attribute_or_message, message], occurrence]
      # p "================"
      [format('activerecord.errors.models.%s.%s.%s', model, attribute_or_message, message), occurrence]
    end
  end
end

I18n::Tasks.add_scanner 'ScanActiveRecordsErrors'
