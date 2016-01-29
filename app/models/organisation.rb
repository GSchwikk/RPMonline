class Organisation < ActiveRecord::Base

	mount_uploader :image, ImageUploader

	has_many :users
	has_many :divisions, dependent: :destroy
	has_many :kpis

end
