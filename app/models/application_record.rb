class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def generate_id(characters = 5)
    SecureRandom.alphanumeric(characters)
  end
end
