class Article < ActiveRecord::Base
  include PgSearch::Model

  paginates_per 5

  multisearchable against: [:headline, :description, :body]

  enum status: { active: 'active', archived: 'archived', draft: nil }

  belongs_to :user

  has_many :votes, as: :voteable
  has_many :comments, as: :commentable, dependent: :destroy

  has_attached_file :image, styles: {
    thumb: '100x100>',
    small: '150x150#',
    square: '200x200#',
    medium: '300x300>'
  }

  validates :headline, :description, :body, presence: true unless :draft?
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def share_text
    "Check out this awesome post on ocate.Life called \"#{headline}\""
  end
end