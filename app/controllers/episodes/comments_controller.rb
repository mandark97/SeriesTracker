class Episodes::CommentsController < CommentsController
  before_action :set_commentable

  private

    def set_commentable
      @commentable = Episode.find(params[:episode_id])
    end
end