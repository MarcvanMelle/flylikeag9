class Word < ApplicationRecord
  max_paginates_per 20
  belongs_to :user
  has_many :reviews

  validates :word, presence: true, allow_blank: false
  validates :definition, presence: true, allow_blank: false
end
