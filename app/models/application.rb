class Application < ApplicationRecord
  belongs_to :user
  belongs_to :job

  enum status: { pending: 0, approved: 1, rejected: 2 }
end
