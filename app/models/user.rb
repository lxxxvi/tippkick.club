class User < ApplicationRecord
  FIFA_COUNTRY_CODES = I18n.t('shared.fifa_country_codes').keys.map(&:to_s).freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_many :predictions, dependent: :destroy

  before_validation :initialize_nickname
  before_save :set_tippkick_id

  validates :nickname, presence: true
  validates :nickname, uniqueness: true
  validates :rooting_for_team, inclusion: { in: FIFA_COUNTRY_CODES, allow_blank: true }
  after_create :create_predictions!
  after_create :add_to_global_team!

  def membership_for(team)
    memberships.find_by(team: team)
  end

  private

  def create_predictions!
    CreatePredictionsService.new(self).call!
  end

  def add_to_global_team!
    Team.global.find_or_create_member(self)
  end

  def initialize_nickname
    self.nickname ||= generate_id
  end

  def set_tippkick_id
    self.tippkick_id = generate_id
  end
end
