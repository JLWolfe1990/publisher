class AddAltIdToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :alt_id, :string
    add_index :articles, :alt_id, unique: true
  end
end
