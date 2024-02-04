class JobsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_job, only: [:update, :destroy, :apply_user, :unapply_user]

  def index
    render json: current_user.jobs, status: :ok
  end

  def create
    job = current_user.jobs.build(job_params)

    if job.save
      render json: job, status: :created
    else
      render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @job.update(job_params)
      render json: @job, status: :ok
    else
      render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    head :no_content
  end

  def show
    job = Job.find(params[:id])
    render json: @job, status: :ok
  rescue => e
    logger.info e.message
    head :no_content
  end

  def applieds
    render json: current_user.applied_jobs, status: :ok
  end

  def apply
    job = Job.find(params[:id])
    # cant apply to your job
    if job.user_id == current_user.id
      head :unprocessable_entity
    else
      application = job.applications.build(user_id: current_user.id)
      if application.save
        head :created
      else
        render json: { errors: application.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def apply_user
    application = @job.applications.build(user_id: params[:user_id])
    if application.save
      head :created
    else
      render json: { errors: application.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def unapply_user
    application = @job.applications.find_by(user_id: params[:user_id])
    if application.blank?
      head :no_content
    else
      application.rejected!
      head :ok
    end
  end

  private

  def find_job
    @job = current_user.jobs.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :no_content
  end

  def job_params
    params.require(:job).permit(:title, :description, :company, :location, :job_type, :category, :salary, :requirements, :responsibilities)
  end
end
