class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  has_one_attached :image
  validates :image, content_type: { in: [:png, :jpg, :jpeg, :gif], message: "Image should have valid image format(png,jpg,jpeg,gif)."}
  validates :image, size: { less_than: 5.megabytes , message: 'should less than 5MB.' }

  # Returns a resized image for display.
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
