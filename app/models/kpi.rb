class Kpi < ActiveRecord::Base
  
  has_and_belongs_to_many :packs
  has_many :kpi_datapoints, dependent: :destroy
  belongs_to :organisation

  validates :name, :vector, :units, :target, presence: true
  validates_numericality_of :target
end