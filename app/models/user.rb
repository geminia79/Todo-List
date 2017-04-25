class User < ApplicationRecord
  has_secure_password
  has_many :identities, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_nil: true, :confirmation => true


  def self.from_omniauth(auth_hash)
    identity_params = {uid: auth_hash['uid'], provider: auth_hash['provider']}
    identity = Identity.find_or_initialize_by(uid: auth_hash['uid'], provider: auth_hash['provider'])

    if identity.persisted?
      user = identity.user
    else
      user = User.find_or_initialize_by(email: auth_hash['info']['email'])

      if user.persisted?
        user.identities.create!(identity_params.merge(user_id: user.id))
      else
        user = User.new(email: auth_hash['info']['email'], name: auth_hash['info']['name'], password: SecureRandom.hex(8))
        user.save!
        user.identities.create!(identity_params.merge(user_id: user.id))
      end
    end

    user
  end

  def send_reset_password_instructions
    update!(reset_password_token: generate_token, reset_password_sent_at: DateTime.current)
    UserMailer.password_reset(self).deliver_now
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def within_reset_password_period?
     reset_password_sent_at.present? && reset_password_sent_at < 6.hours.ago
  end

  def self.search(search)
    if search.present?
      where('lower(name) LIKE :search OR lower(email) LIKE :search', search: "%#{search.downcase}%")
    else
      all
    end
  end
end
