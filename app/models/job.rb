class Job < ApplicationRecord
  # created by this user
  belongs_to :user

  # applicants and users that want to apply to job
  has_many :applications
  has_many :applicants, through: :applications, source: :user
end
