class Article < ActiveRecord::Base
  include PgSearch
  multisearchable against: [:headline, :description, :body]

  # :headline, :description, :body

  belongs_to :user

  has_attached_file :image, styles: {
    thumb: '100x100>',
    small: '150x150#',
    square: '200x200#',
    medium: '300x300>'
  }

  validates :headline, :description, :body, presence: true
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end