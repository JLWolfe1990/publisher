class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :category
      t.references :voteable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
