class TopicRequest < ActiveRecord::Base
  include PgSearch::Model
  multisearchable against: [:title, :description]

  belongs_to :requester, class_name: 'User'

  has_many :votes, as: :voteable, dependent: :destroy

  validates :title, :description, presence: true

  def voteable?(user)
    votes.where(user_id: user.id).blank?
  end

  def upvote(user)
    touch
    votes.create user: user, category: Vote.categories[:up]
  end

  def up_vote_count
    votes.up_votes.count
  end

  def downvote(user)
    touch
    votes.create user: user, category: Vote.categories[:down]
  end

  def down_vote_count
    votes.down_votes.count
  end

  def tracks_popularity?
    true
  end
end