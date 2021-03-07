class Training < ApplicationRecord
  belongs_to :user
  has_many :clears, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 300}
  validates :tag, allow_blank: true, length: {maximum: 10}
  validates :end_on, presence: true
  validate :validate_end_time

  private
  def validate_end_time
    if end_on?
      time = (end_on - Date.today).to_i
      if time >= 11
        errors.add(:end_on, "は今日から10日以内にしてください")
      elsif time <= 0
        errors.add(:end_on, "は明日以降でお願いします")
      end

    end
  end
end
