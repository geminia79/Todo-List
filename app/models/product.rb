class Product < ApplicationRecord
  belongs_to :user

  scope :for_user, -> (user_id) { where(user_id: user_id) }

  self.per_page = 10
end
