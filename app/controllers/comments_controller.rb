class CommentsController < ApplicationController
  before_action :check_login

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    @comment.user_name = current_user.name
    @comment.save
    redirect_to(:back)
  end

  private

    def check_login
      redirect_to root_path unless current_user
    end

    def comment_params
      params.require(:comment).permit(:body, :name)
    end
end