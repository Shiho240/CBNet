class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :first_name, :last_name, :username, :password, :password_confirmation
  
  
  has_many :games, :dependent => :destroy
  has_many :relationships, :dependent=> :destroy, :foreign_key => "follower_id"
  has_many :following, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :dependent => :destroy, :foreign_key => "followed_id", :class_name => "Relationship" 
  has_many :followers, :through => :reverse_relationships, :source => :follower
  email_expr = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  
  validates :username, :presence => true,
						:length => {:maximum => 16},
						:uniqueness => {:case_sensative => false}
  validates :email, :presence=> true,
					:format => {:with => email_expr},
					:uniqueness => {:case_sensative => false}
  validates :password, :presence => true,
					   :confirmation => true, 
					   :length => {:within => 6..40}
					   
					   
before_save :encrypt_password
def feed
Game.where("user_id = ?", id)
end
def has_password?(submitted_password)
	encrypted_password == encrypt(submitted_password)

end

def following?(followed)
relationships.find_by_followed_id(followed)
end

def follow!(followed)
relationships.create!(:followed_id =>followed.id)
end

def unfollow!(followed)
relationships.find_by_followed_id(followed).destroy
end

class << self
    def authenticate(username, submitted_password)
      user = find_by_username(username)
      (user && user.has_password?(submitted_password)) ? user : nil
    end
    
    def authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end
  end
  
private

def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end
  
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
					   
end
