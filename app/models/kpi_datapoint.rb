class KpiDatapoint < ActiveRecord::Base
  
  belongs_to :kpi

  validates :date, :value, presence: true

  scope :wkvalue, -> (start) {where date: start if start.present?} 


  # def self.wkvalue(startdate)
  #  	find("date = ?", startdate)
  # end

  # def self.1wkvalue(startdate,kpi_id)
  #  	find("date = ?" and "kpi_id = ?", startdate, kpi_id)
  # end


  # kpi.kpi_datapoints.4wkvalues.average(:values).round(2)

  #scope :4wkvalues, ->(time) { where("reviews.created_at > ?", 4.week.ago) if time.present? }


end