class DesignsController < ApplicationController
  before_action :set_design, only: [:show,:edit,:update,:destroy]
  def index
    @user = current_user
    case @user.role
    when 'employee'
      @designs = policy_scope(Design.where(status: 'activo'))
    when 'production_manager', 'engineering_manager'
      @designs = policy_scope(Design)
    when 'engineer'
      @designs = policy_scope(Design.where(user: current_user, status: 'activo'))
    end

    params[:query].present? ? (@designs = Design.where("project_number LIKE '%#{params[:query]}%' OR project_name LIKE '%#{params[:query].upcase}%'")) : (@designs = Design.all)
  end

  def all_designs
    @user = current_user
    case @user.role
    when 'production_manager', 'engineering_manager'
      @designs = Design.all
    when 'engineer'
      @designs = Design.where(user: current_user).order("updated_at DESC")
    end
    authorize @designs
  end

  def new
    @design = Design.new
    @user = current_user
    authorize @design
  end

  def create
    @design = Design.new(design_params)
    @user = current_user
    authorize @design
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
    @user = current_user
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
    params.require(:design).permit(
      :project_number, :client,
      :project_name, :responsible,
      :revision, :line,
      :status, :autodesk_link,
      :server_path, :user_id,
      :document
    )
  end
end
