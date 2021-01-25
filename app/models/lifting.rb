class Lifting < ApplicationRecord
  VALID_RECORD_REGEX = /\A[0-9]+\z/
  validates :record, presence: true,length: {maximum: 4, too_long: "10000回以上！？ すごいね！" },
       format:{with: VALID_RECORD_REGEX}

  validates :remark, allow_blank: true, length: {maximum: 300}

  belongs_to :user

  validates :user_id, uniqueness: { conditions: -> { where('created_at >= ?', 1.days.ago) }, message: 'どうやらすでに今日の分の記録はしているようですね'}, on: :create
end
