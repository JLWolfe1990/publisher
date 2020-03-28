class ArticlesController < ApplicationController
  before_action :find_article, only: :show
  before_action :populate_articles, only: [:welcome, :index]
  load_and_authorize_resource except: :show

  respond_to :html

  def welcome
    @topic_requests = TopicRequest.order(popularity: :desc, updated_at: :desc).limit(10)
  end

  def index
  end

  def new
    respond_with(@article)
  end

  def create
    @article.user = current_user

    respond_with(@article) do |format|
      format.html { render :new } unless @article.save!
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

  def populate_articles
    @articles = Article.all
    @status = params[:status] || 'active'
    @articles = @articles.order(created_at: :desc).where(status: @status).page(params[:page])
  end

  def find_article
    @article = Article.find_by(id: params[:id]) || Article.find_by(alt_id: params[:id])
    authorize! :read, @article
  end

  def create_params
    params.require(:article).permit(:body, :description, :headline, :image, :status, :alt_id)
  end

  def update_params
    params.require(:article).permit(:body, :description, :headline, :image, :status, :alt_id)
  end
end
