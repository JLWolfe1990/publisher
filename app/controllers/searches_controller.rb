class SearchesController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  def show
    @search_results = PgSearch.multisearch(@search.query).includes(:searchable).group_by(&:searchable_type)
  end

  def create
    @search.user = current_user
    @search.save
    redirect_to search_path(@search)
  end

  private

  def create_params
    params.require(:search).permit(:query, :user_id)
  end
end