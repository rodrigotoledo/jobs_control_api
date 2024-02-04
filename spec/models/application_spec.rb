require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'associations' do
    let(:user) { create(:user) }
    let(:job) { create(:job) }

    describe 'associations' do
      it 'belongs to a user and a job' do
        application = create(:application, user: user, job: job)

        expect(application.user).to eq(user)
        expect(application.job).to eq(job)
      end
    end

    describe 'enum status' do
      it 'has enum status with values: pending, approved, rejected' do
        expect(Application.statuses.keys).to match_array(%w[pending approved rejected])
      end
    end
  end


  describe 'validations' do
    it 'ensures uniqueness of user_id scoped to job_id' do
      user = create(:user)
      job = create(:job)
      create(:application, user: user, job: job) # Existing application

      new_application = build(:application, user: user, job: job)
      expect(new_application).not_to be_valid
      expect(new_application.errors[:user_id]).to include('User has already applied to this job')
    end

    it 'allows the same user to apply to different jobs' do
      user = create(:user)
      job1 = create(:job)
      job2 = create(:job)

      create(:application, user: user, job: job1) # Existing application for job1

      new_application = build(:application, user: user, job: job2)
      expect(new_application).to be_valid
    end

    it 'allows different users to apply to the same job' do
      user1 = create(:user)
      user2 = create(:user)
      job = create(:job)

      create(:application, user: user1, job: job) # Existing application for user1

      new_application = build(:application, user: user2, job: job)
      expect(new_application).to be_valid
    end

    it 'is not valid if user is the job owner' do
      job = create(:job)
      application = build(:application, user: job.user, job: job)
      expect(application).not_to be_valid
      expect(application.errors[:user_id]).to include('User cannot apply to their own job')
    end
  end
end
