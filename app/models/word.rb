class Word < ApplicationRecord
  max_paginates_per 20
  belongs_to :user
  has_many :reviews
end
