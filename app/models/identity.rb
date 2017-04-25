class Identity < ApplicationRecord
  belongs_to :user, optional: true

  validates :uid, presence: true, uniqueness: { scope: :provider }
end
