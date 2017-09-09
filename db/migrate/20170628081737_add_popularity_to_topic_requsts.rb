class AddPopularityToTopicRequsts < ActiveRecord::Migration[5.0]
  def change
    add_column :topic_requests, :popularity, :integer, default: 0
  end
end
