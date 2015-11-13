class Meeting < ActiveRecord::Base

	validates :name, :division, presence: true
	has_many :packs

end
