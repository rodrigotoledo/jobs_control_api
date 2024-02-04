class Application < ApplicationRecord
  belongs_to :user
  belongs_to :job
  validate :user_is_not_job_owner
  validates :user_id, uniqueness: { scope: :job_id, message: 'User has already applied to this job' }

  enum status: { pending: 0, approved: 1, rejected: 2 }
  private

  def user_is_not_job_owner
    errors.add(:user_id, 'User cannot apply to their own job') if user_id == job&.user_id
  end
end
