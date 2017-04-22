class AddImageToArticles < ActiveRecord::Migration[5.0]
  def change
    add_attachment :articles, :image
  end
end
