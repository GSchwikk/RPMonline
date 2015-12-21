class Meeting < ActiveRecord::Base

	validates :name, :division, presence: true
	belongs_to :division
	belongs_to :user
	belongs_to :organisation
	has_many :packs

end
