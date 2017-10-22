class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true
      t.references :commentable, polymorphic: true, index: true
      t.text :body
      t.timestamps
    end
  end
end
