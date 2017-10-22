class CommentsController < ApplicationController
  # load_and_authorize_resource :comment, through: :commentable
  load_and_authorize_resource

  respond_to :json, :html

  def new
    @commentable = Article.find(params[:article_id]) if params[:article_id]
    @comment.user = current_user

    respond_with(@comment) do |format|
      format.html do
        render partial: 'comments/new'
      end
    end
  end

  def create
    @comment.save

    redirect_to polymorphic_path(@comment.commentable)
  end

  def destroy
    url = polymorphic_path(@comment.commentable)

    @comment.destroy

    redirect_to url
  end

  private

  def create_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :user_id)
  end
end
