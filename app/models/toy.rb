class Toy < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  validates :name, presence: true
  validates :description, length: { maximum: 255, optional: true}
  has_many_attached :images
  validates :images, content_type: { in: [:png, :jpg, :jpeg, :gif], message: "Images should have valid image format(png,jpg,jpeg,gif)."}

  self.per_page = 6
end