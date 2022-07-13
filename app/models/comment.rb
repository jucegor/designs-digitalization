class Comment < ApplicationRecord
  has_one_attached :annex
  has_many :answer, dependent: :destroy
end
