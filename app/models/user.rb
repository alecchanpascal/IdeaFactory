class User < ApplicationRecord
    has_secure_password

    has_many :ideas, dependent: :destroy
    has_many :reviews, dependent: :destroy

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :name, presence: true
    validates :email, presence: true, uniqueness: {case_sensitive: false}, format: VALID_EMAIL_REGEX

    has_many :likes, dependent: :destroy
    has_many :liked_ideas, through: :likes, source: :idea
end
