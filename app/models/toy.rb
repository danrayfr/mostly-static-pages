class Toy < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  validates :name, presence: true
  has_rich_text :description
  validates :description, presence: true, length: { maximum: 255 }
  has_many_attached :images
  validates :images, content_type: { in: [:png, :jpg, :jpeg, :gif], message: "Images should have valid image format(png,jpg,jpeg,gif)."}
  validates :images, size: { less_than: 5.megabytes , message: 'should less than 5MB.' }

  self.per_page = 6

  def date_listed
    created_at.strftime("%B %d, %Y at %I:%M%p")
  end

  def truncated_description
    description.to_plain_text.truncate(50)
  end
  
end