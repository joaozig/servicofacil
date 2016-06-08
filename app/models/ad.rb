class Ad < ActiveRecord::Base
	enum status: { pending: 0, approved: 1, rejected: 2 }

	belongs_to :advertiser
	belongs_to :subcategory

	validates :title, presence: true
	validates :subcategory, presence: true

	default_scope { order(id: :desc) }
	scope :approved, -> { where(status: Ad.statuses[:approved]).order(premium: :desc, title: :asc) }
end
