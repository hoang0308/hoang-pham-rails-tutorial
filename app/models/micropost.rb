class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(create_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.content_maximum}
  validates :image,presence: true, content_type: [:png, :jpg, :jpeg, :gif], size: { less_than: 5.megabytes}

  def display_image
    image.variant(resize_to_limit: [500,500])
  end
end