class Kpi_datapoints < ActiveRecord::Base
  
  belongs_to :kpi

  validates :date, :value, presence: true

  # def self.4wkvalues
  # 	where("date > ?", 4.week.ago)
  # end

  # kpi.kpi_datapoints.4wkvalues.average(:values).round(2)

  #scope :4wkvalues, ->(time) { where("reviews.created_at > ?", 4.week.ago) if time.present? }


end