class Review < ApplicationRecord
  belongs_to :user
  belongs_to :word
  has_many :votes

  validates :rating, presence: true
  validates :body, presence: true, allow_blank: false
end
