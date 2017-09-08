class Tag < ApplicationRecord
  belongs_to :site
  has_many :product_tags, dependent: :destroy

end
