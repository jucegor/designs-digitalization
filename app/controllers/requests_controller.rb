class RequestsController < ApplicationController
  before_action :set_request, only: %i[show edit update destroy]
  def all_requests
    @requests = policy_scope(Request)
    @designs = Design.all
    authorize @requests
    @user = current_user
  end

  def new_project
    @request = Request.new
    @user = current_user
    authorize @request
  end

  def new
    @request = Request.new
    @user = current_user
    @designs = Design.all
    authorize @request
  end

  def create
    @request = Request.new(request_params)
    @designs = Design.all
    authorize @request
    if @request.save
      redirect_to all_requests_path
    else
      render "new"
    end
  end

  def update
    @request.update(request_params)
    redirect_to all_requests_path
  end

  def edit
    @designs = Design.all
  end

  def show
    @user = current_user
  end

  def destroy
    @request.destroy
    authorize @request
    redirect_to requests_path
  end

  private

  def set_request
    @request = Request.find(params[:id])
    authorize @request
  end

  def request_params
    params.require(:request).permit(
      :project_number_req, :project_name_req,
      :required_date, :status, :design_id
    )
  end
end
