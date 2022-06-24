class Design < ApplicationRecord
  belongs_to :user
  has_one_attached :document
  has_many :request

  include PgSearch::Model
  pg_search_scope :global_search,
    against: %i[project_number project_name responsible],
    using: {
      tsearch: { prefix: true }
    }
end
