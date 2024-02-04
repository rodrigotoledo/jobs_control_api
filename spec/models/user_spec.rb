# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:cellphone) }
    it { should validate_presence_of(:address) }
  end

  describe 'has_secure_password' do
    it { should have_secure_password }
  end

  it 'normalizes email before validation' do
    user = build(:user, email: '  USER@EXAMPLE.COM  ')
    user.valid?
    expect(user.email).to eq('user@example.com')
  end


  describe 'associations' do
    let(:user) { create(:user) }
    let!(:jobs) { create_list(:job, 3, user: user) }

    let!(:jobs_with_applications) do
      jobs = create_list(:job, 2)
      jobs.each { |job| create(:application, user: user, job: job, status: :pending) }
      jobs
    end

    let!(:jobs_with_approved_applications) do
      jobs = create_list(:job, 2)
      jobs.each { |job| create(:application, user: user, job: job, status: :approved) }
      jobs
    end

    let!(:applied_jobs) do
      jobs_with_applications + jobs_with_approved_applications
    end

    describe 'associations' do
      it 'has many jobs, applied_jobs, and working_jobs' do
        expect(user.jobs).to match_array(jobs)
        expect(user.applied_jobs.size).to eql(4)
        expect(user.working_jobs).to match_array(jobs_with_approved_applications)
      end
    end
  end
end
