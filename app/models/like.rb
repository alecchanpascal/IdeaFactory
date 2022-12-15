class Like < ApplicationRecord
  belongs_to :user
  belongs_to :idea

  validates(:idea_id, uniqueness: {scope: :user_id, message: "You already liked this idea"})
end
