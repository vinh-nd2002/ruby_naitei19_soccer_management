class User < ApplicationRecord
  before_save :downcase_email!
  attr_accessor :remember_token

  validates :phone, presence: true
  validates :name, presence: true, length: {maximum: Settings.users.max_name}
  validates :password, presence: true,
                       length: {minimum: Settings.users.min_password},
                       format: {with: Settings.users.valid_password_regex}
  validates :email, presence: true,
                    length: {maximum: Settings.users.max_email},
                    format: {with: Settings.users.valid_email_regex},
                    uniqueness: true
  has_secure_password
  # association
  has_many :favorite_pitches, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  class << self
    # Returns the hash digest of the given string.
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost:
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # Returns true if the given token matches the digest.
  def authenticated? remember_token
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_column(:remember_digest, nil)
  end

  def session_token
    remember_digest || remember
  end

  private
  def downcase_email!
    email.downcase!
  end
end
