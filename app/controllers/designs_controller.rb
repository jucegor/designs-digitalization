class DesignsController < ApplicationController
  before_action :set_design, only: [:show,:edit,:update,:destroy]
  def index
    @designs = policy_scope(Design.where(user: current_user, status: 'activo'))
    @user = current_user
  end

  def all_designs
    @designs = Design.where(user: current_user)
    @user = current_user
    authorize @designs
  end

  def new
    @design = Design.new
    authorize @design
    @user = current_user
  end

  def create
    @design = Design.new(design_params)
    authorize @design
    @user = current_user
    @design.responsible = @user.responsible
    if @design.save
      redirect_to @design
    else
      render "new"
    end
  end

  def edit
    @user = current_user
  end

  def show
  end

  def update
    @design.update(design_params)
    redirect_to @design
  end

  def destroy
    @design.destroy
    redirect_to designs_path
  end

  private

  def set_design
    @design = Design.find(params[:id])
    authorize @design
  end

  def design_params
    params.require(:design).permit(:project_number, :client, :project_name, :responsible, :revision, :line, :status, :autodesk_link, :server_path)
  end
end
