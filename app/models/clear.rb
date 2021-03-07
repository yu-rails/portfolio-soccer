class Clear < ApplicationRecord
  belongs_to :user
  belongs_to :training
  validates :user_id, presence: true
  validates :training_id, presence: true
  validates_uniqueness_of :training_id, scope: :user_id
end
