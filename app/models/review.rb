class Review < ApplicationRecord
  belongs_to :user
  belongs_to :word

  validates :rating, presence: true
  validates :body, presence: true, allow_blank: false
end
