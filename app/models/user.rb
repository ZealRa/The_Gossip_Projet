class User < ApplicationRecord
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    has_many :gossips
    has_many :tags
    has_many :recipients
    has_many :messages, through: :recipients
    has_many :comments
    belongs_to :city, optional: true
end
