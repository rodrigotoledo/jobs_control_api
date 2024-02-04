require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'associations' do
  let(:user) { create(:user) }
  let!(:jobs) { create_list(:job, 3, user: user) }

  let!(:jobs_with_applications) do
    create_list(:job, 2).tap do |jobs|
      jobs.each { |job| create(:application, user: user, job: job, status: :pending) }
    end
  end

  let!(:jobs_with_approved_applications) do
    create_list(:job, 2).tap do |jobs|
      jobs.each { |job| create(:application, user: user, job: job, status: :approved) }
    end
  end

  describe 'associations' do
    it 'belongs to a user, has many applicants' do
      expect(jobs.map(&:user)).to all(eq(user))

      jobs_with_applications.each do |job|
        expect(job.applicants).to match_array([user])
      end

      jobs_with_approved_applications.each do |job|
        expect(job.applicants).to match_array([user])
      end
    end
  end
end

end
