class Category < ApplicationRecord
  has_many :items
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: :true

  validates :name, presence: true
end
