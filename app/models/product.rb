class Product < ApplicationRecord
  belongs_to :user

  scope :for_user, -> (user_id) { where(user_id: user_id) }

  self.per_page = 10

  # has_many :purchases
  # has_many :buyers, through: :purchases

  has_attached_file :product_image, styles: { medium: "320x150#", thumb: "100x100#", medium_1: "800x300#" }, default_url: "/assets/missing-products.png"
  validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\z/

  def self.filter_by_user(user_id)
    if user_id.present?
      for_user(user_id)
    else
      all
    end
  end
end
