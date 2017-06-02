class Vote < ActiveRecord::Base
  enum category: { up: 1, down: -1 }

  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :category, :user, :voteable, presence: true
  validates :voteable_id, uniqueness: { scope: :user_id }

  scope :up_votes, -> { where(category: :up) }
  scope :down_votes, -> { where(category: :down) }
end