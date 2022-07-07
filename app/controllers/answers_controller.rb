class AnswersController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  def index
    @user = current_user
    case @user.role
    when 'employee'
      @designs = policy_scope(Design.where(status: 'activo'))
      @all = Answer.all
    when 'production_manager', 'engineering_manager'
      @designs = policy_scope(Design)
      @all = Answer.all
    when 'engineer'
      @designs = policy_scope(Design.where(user: current_user, status: 'activo'))
      @all = Answer.all
    end
  end

  def create
    @answer = Answer.new(answer_params)

    authorize @answer
    if @answer.save
      @route = Comment.find(@answer.comment_id)
      redirect_to design_path(@route.design_id), notice: 'Respuesta realizado con Exito'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @answer = Answer.new
  end

  def edit
    @user = current_user
  end

  def update
    if @answer.update(answer_params)
      @route = Comment.find(@answer.comment_id)
      redirect_to design_path(@route.design_id), notice: 'Respuesta Actualizada con Exito'
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    if @answer.destroy
      @route = Comment.find(@answer.comment_id)
      redirect_to design_path(@route.design_id), notice: 'Respuesta Eliminada con Exito'
    else
      render :edit, status: unprocessable_entity
    end
  end

  private

  def set_comment
    @answer = Answer.find(params[:id])
    authorize @answer
  end

  def answer_params
    params.require(:answer).permit(:user, :comment_id, :answer, :answerimg)
  end
end
