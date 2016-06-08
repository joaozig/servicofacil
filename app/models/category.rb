class Category < ActiveRecord::Base
	has_many :subcategories

	validates :name, presence: true

	default_scope { order(name: :asc) }
end
