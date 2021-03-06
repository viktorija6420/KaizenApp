class User < ApplicationRecord
  attr_accessor :remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save { email.downcase! }

  validates :first_name,  presence: true, length: { maximum: 200 }
  validates :last_name, presence: true, length: { maximum: 200 }
  validates :age, presence: true, length: { maximum: 200 }
  validates :sex, presence: true, length: { maximum: 200 }
  validates :email, presence: true, length: { maximum: 200 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :phone, presence: true, length: { maximum: 200 }
  validates :role, presence: true, length: { maximum: 200 }
  validates :password, presence: true, length: { minimum: 6 }

  # Returns the hash digest of the given string. ONLY PAY ATTENTION TO IF WANT TO USE FIXTURES FOR USER INSTEAD OF FACTORIES
  # used for remember method
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  has_secure_password

  # returns a random token - for remember token (sessions)
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # update_attribute bypasses validations - neccessary because we don't have access to password or confirmation
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

end
