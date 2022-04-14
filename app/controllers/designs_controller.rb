class DesignsController < ApplicationController

  def index
    @designs = Design.where(user: current_user)
  end

  def new
    @design = Design.new
  end

  def create
    @design = Design.new(design_params)
    @design.save
    redirect_to designs_path
  end

  def edit
    @design = Design.find(params[:id])
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
    params.require(:design).permit(:project_number, :client, :project_name, :responsable, :revision, :line, :status, :autodesk_link, :server_path)
  end

end
