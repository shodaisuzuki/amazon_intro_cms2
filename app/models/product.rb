class Product < ApplicationRecord
  belongs_to :site
  has_many :product_tags, dependent: :destroy
  
  attachment :image

  # TODO: 後で戻す
  # validates :title, presence: true
  # validates :plice, presence: true
  # validates :image, presence: true
  # validates :introduction, presence: true
  # validates :amazon_id, presence: true
  # validates_presence_of :image
end
