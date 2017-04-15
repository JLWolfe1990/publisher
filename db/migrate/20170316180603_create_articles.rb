class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :headline
      t.text :description
      t.text :body
      t.belongs_to :user, foreign_key: true
    end
  end
end
