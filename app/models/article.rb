class Article < ActiveRecord::Base
  # :headline, :description, :body

  validates :headline, :description, :body, presence: true
  belongs_to :user
end