class Meeting < ActiveRecord::Base

	validates :name, :division, presence: true
	belongs_to :division
	belongs_to :user
	has_many :packs, dependent: :destroy

end
