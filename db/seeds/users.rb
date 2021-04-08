# rubocop:disable Rails/SkipsModelValidations
User.transaction do
  User.update_all(admin: false)
  emails = ENV['TIPPKICK_ADMIN_EMAILS']&.split(',')
  updated_rows = User.where(email: emails).update_all(admin: true)
  Rails.logger.info "  - #{updated_rows} users updated to admin"
  Rails.logger.info "  - Admins: #{emails}"
end
# rubocop:enable Rails/SkipsModelValidations
