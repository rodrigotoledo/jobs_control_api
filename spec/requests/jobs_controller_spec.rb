require 'rails_helper'

RSpec.describe 'JobsController', type: :request do
  let!(:user) { create(:user) }

  describe 'Jobs that user have' do

    before do
      sign_in user
      create_list(:job, 5, user: user)
      create_list(:application, 10, user: user)
    end

    it 'jobs that user have' do
      get jobs_path
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(5)
    end

    it 'jobs that current user have applied' do
      get applieds_jobs_path
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(10)
    end

    context 'create jobs for logged user' do
      let(:valid_params) { { job: attributes_for(:job) } }
      let(:invalid_params) { { job: { title: '' } } }

      it 'create with success' do
        post jobs_path, params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'create with success' do
        post jobs_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'update job for logged user' do
      let!(:job) { create(:job, user: user) }
      let(:valid_params) { { job: attributes_for(:job) } }
      let(:invalid_params) { { job: { title: '' } } }

      it 'update with success' do
        put job_path(job.id), params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it 'update with success' do
        put job_path(job.id), params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'Job not found for current user' do
        put job_path(-1)
        expect(response).to have_http_status(:no_content)
      end
    end


    describe 'POST #apply_user' do
      let!(:job) { create(:job) }
      let!(:invalid_job) { create(:job, user: user) }

      it 'owner of job cant apply it self' do
        post apply_job_path(invalid_job.id)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'apply to a job with success' do
        post apply_job_path(job.id)
        expect(response).to have_http_status(:created)
      end

      context 'error applying' do
        before do
          create(:application, user: user, job: job)
        end
        it 'error when try to apply to same job' do
          post apply_job_path(job.id)
          expect(response).to have_http_status(:unprocessable_entity)
          json_response = JSON.parse(response.body)
          expect(json_response).to have_key('errors')
        end
      end
    end

    describe 'current user apply another user to a job' do
      let!(:job) { create(:job, user: user) }
      let!(:another_user) {create(:user) }

      it 'owner of job cant apply it self' do
        post apply_user_job_path(id: job.id, user_id: user.id)
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('errors')
      end

      it 'apply to a job with success' do
        post apply_user_job_path(job.id, user_id: another_user.id)
        expect(response).to have_http_status(:created)
      end
    end

    describe 'DELETE #job of current_user' do
      let!(:job) { create(:job, user: user) }
      it 'when destroy job with success' do
        delete job_path(job.id)
        expect(response).to have_http_status(:no_content)
      end
    end

    describe 'DELETE #unapply_user' do

      let!(:job) { create(:job, user: user) }
      let!(:application) { create(:application, job: job) }
      context 'when user unapplies from a job' do
        it 'marks the application as rejected' do
            delete unapply_user_job_path(application.job_id, user_id: application.user_id)
            expect(application.reload.rejected?).to be true
            expect(response).to have_http_status(:ok)
          end
        end

      context 'when user did not apply to the job' do
        it 'responds with no content status' do
          delete unapply_user_job_path(job.id, user_id: -1)
          expect(response).to have_http_status(:no_content)
        end
      end
    end
  end

  context 'Information about job' do
    let(:job) { create(:job) }

    it 'returns informatiou about job' do
      get job_path(job.id)
      expect(response).to have_http_status(:ok)
    end

    it 'returns nothing when error occurs' do
      get job_path(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
