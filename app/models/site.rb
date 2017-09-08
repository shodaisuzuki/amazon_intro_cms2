class Site < ApplicationRecord
  belongs_to :user

  has_many :tags, dependent: :destroy
  has_many :products, dependent: :destroy

end
