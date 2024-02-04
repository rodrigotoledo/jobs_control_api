class Job < ApplicationRecord
  validates :title, :description, :company, :status, :location, :job_type, :category, :requirements, :responsibilities, presence: true
  validates :salary, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :status, inclusion: { in: %w(open closed), message: "%{value} is not a valid status" }

  enum status: { open: 'open', closed: 'closed' }
  enum job_type: { full_time: 'full_time', part_time: 'part_time', temporary: 'temporary' }

  scope :open_jobs, -> { where(status: 'open') }
  scope :closed_jobs, -> { where(status: 'closed') }

  # created by this user
  belongs_to :user

  # applicants and users that want to apply to job
  has_many :applications
  has_many :applicants, through: :applications, source: :user
end
