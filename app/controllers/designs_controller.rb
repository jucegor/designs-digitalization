class DesignsController < ApplicationController
  def index
    @designs = Design.all
  end

  def new
    @design = Design.new
  end

  def create
    @design = Design.new(design_params)
    @design.save
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
    redirect_to design_path(@design)
  end

  def destroy

  end

  private

  def design_params
    params.require(:design).permit(:project_number, :client, :project_name, :responsable, :revision, :line, :status, :autodesk_link, :server_path)
  end

end
