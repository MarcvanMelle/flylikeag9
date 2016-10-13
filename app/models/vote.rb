class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user, presence: true
  validates :review, presence: true
  validates :up_down, inclusion: { in: [true, false] }
end
