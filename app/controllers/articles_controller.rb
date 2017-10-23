class ArticlesController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  def welcome
    @topic_requests = TopicRequest.order(popularity: :desc, updated_at: :desc).limit(10)
    @articles = @articles.order(created_at: :desc).limit(3)
  end

  def index
    @articles = @articles.order(created_at: :desc).page(params[:page])
  end

  def new
    respond_with(@article)
  end

  def create
    respond_with(@article) do |format|
      unless @article.save
        format.html { render :new }
      end
    end
  end

  def show
    respond_with(@article)
  end

  def edit
  end

  def update
    respond_with(@article) do
      if @article.update update_params
        return render :show
      else
        return render :edit
      end
    end
  end

  private

  def create_params
    params.require(:article).permit(:body, :description, :headline, :image)
  end

  def update_params
    params.require(:article).permit(:body, :description, :headline)
  end
end
