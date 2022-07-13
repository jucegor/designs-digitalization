class CommentsController < ApplicationController
  before_action :set_comment, only: [:show,:edit,:update,:destroy]
  def create
    @comment = Comment.new(comment_params)

    authorize @comment
    if @comment.save
      redirect_to design_path(@comment.design_id), notice: 'Comentario realizado con Exito'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @comment = Comment.new
  end

  def edit
    @user = current_user
  end

  def update

    @id = @comment.design_id
    if @comment.update(comment_params)
      redirect_to design_path(@id), notice: 'Comentario Actualizado'
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    @id = @comment.design_id
    if @comment.destroy
      redirect_to design_path(@id), notice: 'Comentario Eliminado'
    else
      render :edit, status: unprocessable_entity
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:design_id, :user, :comment, :hcc, :annex)
  end
end
