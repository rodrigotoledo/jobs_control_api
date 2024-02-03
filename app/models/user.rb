class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :full_name, :phone, :cellphone, :address, presence: true
  normalizes :email, with: ->(email) { email.strip.downcase }

  generates_token_for :password_reset, expires_in: 15.minutes
  generates_token_for :email_confirmation, expires_in: 24.hours


  # jobs that are created by the user
  has_many :created_jobs, class_name: 'Job', foreign_key: :user_id

  # jobs that are trying to apply
  has_many :applications, foreign_key: :user_id
  has_many :applied_jobs, through: :applications, source: :job

  # working jobs
  has_many :working_jobs, -> { where(applications: { status: :approved }) }, through: :applications, source: :job
end
