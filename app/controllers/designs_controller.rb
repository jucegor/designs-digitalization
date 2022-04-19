class DesignsController < ApplicationController
  def index
    @designs = Design.where(user: current_user, status: 'activo')
    @user = current_user
  end

  def all_designs
    @designs = Design.where(user: current_user)
    @user = current_user
  end

  def new
    @design = Design.new
    @user = current_user
  end

  def create
    @design = Design.new(design_params)
    @user = current_user
    @design.responsible = @user.responsible
    if @design.save
      redirect_to @design
    else
      render "new"
    end
  end

  def edit
    @design = Design.find(params[:id])
    @user = current_user
  end

  def show
    @design = Design.find(params[:id])
  end

  def update
    @design = Design.find(params[:id])
    @design.update(design_params)
    redirect_to @design
  end

  def destroy
    @design = Design.find(params[:id])
    @design.destroy
    redirect_to designs_path
  end

  private

  def design_params
    params.require(:design).permit(:project_number, :client, :project_name, :responsible, :revision, :line, :status, :autodesk_link, :server_path)
  end
end
