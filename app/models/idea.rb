class Idea < ApplicationRecord
    belongs_to :user, optional: true

    validates :title, presence: true
    validates :description, presence: true

    has_many :reviews, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user
end
