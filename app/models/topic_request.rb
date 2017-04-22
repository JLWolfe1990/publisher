class TopicRequest < ActiveRecord::Base
  include PgSearch
  multisearchable against: [:title, :description]

  validates :title, :description, presence: true
  belongs_to :requester, class_name: 'User'
end