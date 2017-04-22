class CreateTopicRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :topic_requests do |t|
      t.string :title
      t.text :description
      t.belongs_to :requester, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
