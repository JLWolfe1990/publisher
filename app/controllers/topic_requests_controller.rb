class TopicRequestsController < ApplicationController
  load_and_authorize_resource

  respond_to :html
  respond_to :json, only: [:show]

  def index
    @topic_requests = @topic_requests.order(popularity: :desc, updated_at: :desc)
    @recent_requests = @topic_requests.order(updated_at: :desc)
  end

  def new
    respond_with(@topic_request)
  end

  def create
    @topic_request.requester = current_user
    respond_with(@topic_request) do |format|
      if @topic_request.save
        format.html { redirect_to topic_requests_path }
      else
        format.html { render :new }
      end
    end
  end

  def show
    respond_with(@topic_request)
  end

  def upvote
    @topic_request.upvote(current_user)
  end

  def downvote
    @topic_request.downvote(current_user)
  end

  private

  def create_params
    params.require(:topic_request).permit(:title, :description, :requester)
  end
end
