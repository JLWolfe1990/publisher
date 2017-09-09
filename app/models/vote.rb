class Vote < ActiveRecord::Base
  after_create :update_voteable

  enum category: { up: 1, down: -1 }

  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :category, :user, :voteable, presence: true
  validates :voteable_id, uniqueness: { scope: :user_id }

  scope :up_votes, -> { where(category: :up) }
  scope :down_votes, -> { where(category: :down) }

  private

  def update_voteable
    if voteable.try(:tracks_popularity?)
      popularity = (voteable.votes.up_votes.count || 0) - (voteable.votes.down_votes.count || 0)
      voteable.update_columns popularity: popularity
    end

    true
  end
end