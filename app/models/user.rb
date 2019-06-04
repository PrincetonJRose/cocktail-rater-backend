class User < ApplicationRecord

    has_secure_password

    has_many :reviews
    has_many :comments
    has_many :likes

    validates :username, length: { in: 6..16 }
    validates :username, presence: true
    validates :username, uniqueness: true
    
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    
    validates :password, presence: true
    validates :password, length: { in: 6..16 }

end
