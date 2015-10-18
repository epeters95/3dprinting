class User < ActiveRecord::Base
  after_initialize :ensure_session_token

  validates :username, :password_digest, :session_token, presence: true

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    return self.session_token
  end
  
  def password=(secret)
    self.password_digest = BCrypt::Password.create(secret)
  end
  
  def is_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?

    if user.is_password?(password)
      return user
    else 
      return nil
    end
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
