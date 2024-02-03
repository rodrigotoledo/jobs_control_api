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

end
