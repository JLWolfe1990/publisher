class Article < ActiveRecord::Base
  include PgSearch::Model

  paginates_per 5

  multisearchable against: [:headline, :description, :body]

  enum status: { active: 'active', archived: 'archived', draft: nil }

  belongs_to :user

  has_many :votes, as: :voteable
  has_many :comments, as: :commentable, dependent: :destroy

  has_attached_file :image, styles: {
    small: '150x150#',
    medium: '200x200#',
    large: '300x300#'
  }

  validates :headline, :description, :body, presence: true unless :draft?
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :alt_id, uniqueness: true

  def share_text
    "Check out this awesome post on #{ENV['APP_DISPLAY_NAME']} called \"#{headline}\""
  end
end