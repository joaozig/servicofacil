class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :ads

  validates :name, presence: true
  validates :category, presence: true

	default_scope { order(name: :asc) }
end
