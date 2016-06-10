class Advertiser < ActiveRecord::Base
	has_many :ads

	validates :name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 	default_scope { order(name: :asc) }
end
