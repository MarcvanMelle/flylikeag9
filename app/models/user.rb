class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :words
  has_many :reviews

  validates_uniqueness_of :username
  validates :username, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
