class Product < ApplicationRecord

  has_many :cart_items, dependent: :destroy

  validates :name, presence: true, uniqueness: true 
  validates :image_url, presence: true
  validates :english_name, presence: true, uniqueness: true
  validates_presence_of :description, :price, :measurement_unit, :total_units
end
