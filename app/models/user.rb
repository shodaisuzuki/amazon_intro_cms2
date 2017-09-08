class User < ApplicationRecord
  authenticates_with_sorcery!
  
  has_many :sites, dependent: :destroy

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true
  validates :email, presence: true
end
