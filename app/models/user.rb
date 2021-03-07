class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: {maximum: 10}
  VALID_NICKNAME_REGEX = /\A[a-z0-9]+\z/i
  validates :nickname, presence: true, length: {maximum: 20, minimum: 4},
       format:{with: VALID_NICKNAME_REGEX},
       uniqueness: {message: 'を変更してください  既に使われているものです'}
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  validates :password, presence: true, length: {maximum: 20, minimum: 6},
       format:{with: VALID_PASSWORD_REGEX}
  VALID_BACKNUMBER_REGEX = /\A[0-9]+\z/
  validates :back_number, allow_blank: true, length: {maximum: 2},
       format:{with: VALID_BACKNUMBER_REGEX}
  validates :prefecture, allow_blank: true, length: {maximum: 10}
  mount_uploader :image_name, ImageNameUploader

  has_many :liftings
  has_many :trainings
  has_many :clears, dependent: :destroy

 
end
