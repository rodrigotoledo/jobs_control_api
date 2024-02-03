require 'rails_helper'

RSpec.describe "MyJobs", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/my_jobs/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/my_jobs/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/my_jobs/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/my_jobs/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/my_jobs/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
