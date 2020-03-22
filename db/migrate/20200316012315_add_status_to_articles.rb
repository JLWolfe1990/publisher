class AddStatusToArticles < ActiveRecord::Migration[5.0]
  def up
    add_column :articles, :status, :string

    Article.update_all status: 'active'
  end

  def down
    remove_column :articles, :status
  end
end
