class DesignsController < ApplicationController
  before_action :set_design, only: [:show,:edit,:update,:destroy]
  def index
    @user = current_user
    case @user.role
    when 'employee'
      @designs = policy_scope(search_bar_employee)
    when 'production_manager', 'engineering_manager'
      @designs = policy_scope(search_bar_production)
    when 'engineer'
      @designs = policy_scope(search_bar_engineer)
    end
  end

  def search_bar_employee
    params[:query].present? ? (@designs = Design.where("project_number LIKE '%#{params[:query]}%' OR project_name LIKE '%#{params[:query].upcase}%'")) : (@designs = Design.where(status: 'activo'))
  end

  def search_bar_production
    params[:query].present? ? (@designs = Design.where("project_number LIKE '%#{params[:query]}%' OR project_name LIKE '%#{params[:query].upcase}%'")) : (@designs = Design)
  end

  def search_bar_engineer
    @user = current_user
    params[:query].present? ? (@designs = Design.where("project_number LIKE '%#{params[:query]}%' OR project_name LIKE '%#{params[:query].upcase}%'")) : (Design.where(status: 'activo', responsible: @user.responsible))
  end

  def all_designs
    @user = current_user
    case @user.role
    when 'production_manager', 'engineering_manager'
      @designs = Design.all
    when 'engineer'
      @designs = Design.where(responsible: @user.responsible).order("updated_at DESC")
    end
    authorize @designs
  end

  def new
    @design = Design.new
    @user = current_user
    @users = User.where(role: 'engineer')
    authorize @design
  end

  def create
    @design = Design.new(design_params)
    @user = current_user
    @users = User.where(role: 'engineer')
    authorize @design
    if @design.save
      redirect_to @design
    else
      render "new"
    end
  end

  def edit
    @user = current_user
    @users = User.where(role: 'engineer')
    @responsible = @design.responsible
  end

  def show
    @user = current_user
    @comment = Comment.new
    @comments = Comment.where(design_id: params[:id]).order(id: :desc)
    @hcc = Comment.where(design_id: params[:id]).where(hcc: "activo")
    @hccs = Comment.where(design_id: params[:id]).where(hcc: "activo").count
    @comments_count = Comment.where(design_id: params[:id]).count
    @count_photo = 0
    @comments.each do |photos_count|
      photos_count.annex.present? ? @count_photo += 1 : next
    end
    @allphotos = []
    @comments.each do |all|
      all.annex.present? ? @allphotos.push(all.annex) : next
    end
    @lastphotos = []
    @allphotos.each_with_index do |last, index|
      if index <= 3
        last.present? ? @lastphotos.push(last) : next
      end
    end
    @answer = Answer.new
    @answers = Answer.all.order(id: :desc)
  end

  def update
    @design.update(design_params)
    @user = current_user
    case @user.role
    when 'production_manager', 'engineering_manager'
      redirect_to all_designs_path
    when 'engineer'
      redirect_to @design
    end
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
