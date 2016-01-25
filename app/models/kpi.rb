class Kpi < ActiveRecord::Base
  
  has_and_belongs_to_many :packs
  has_many :kpi_datapoints, dependent: :destroy

  validates :name, :vector, :units, :frequency, presence: true
end