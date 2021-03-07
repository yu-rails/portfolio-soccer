class Favorite < ApplicationRecord
  validates :current_user_id, presence: true
  validates :user_id, presence: true
end
