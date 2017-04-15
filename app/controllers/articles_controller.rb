class ArticlesController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  def index
    respond_with(@articles)
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

  private

  def create_params
    params.require(:article).permit(:body, :description, :headline)
  end
end
