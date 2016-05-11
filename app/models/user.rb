class User < ActiveRecord::Base
  has_many :assignees
  has_many :time_logs
  has_many :activities
  has_many :projects, foreign_key: :manager_id
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable

  enum role: [:member, :leader, :manager]

  validates :name, presence: true, length: {maximum: 50}

  before_create :set_default_role

  private
  def set_default_role
    self.role ||= :member
  end
end