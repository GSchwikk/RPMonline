class Kpi_datapoints < ActiveRecord::Base
  
  belongs_to :kpi

  validates :date, :value, presence: true
end