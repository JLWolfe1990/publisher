class TopicRequestsController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  def new
    respond_with(@topic_request)
  end

  def create
    respond_with(@topic_request) do |format|
      unless @topic_request.save
        format.html { render :new }
      end
    end
  end

  def show
    respond_with(@topic_request)
  end

  private

  def create_params
    params.require(:topic_request).permit(:title, :description, :requester)
  end
end
