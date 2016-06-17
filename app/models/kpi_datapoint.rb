class KpiDatapoint < ActiveRecord::Base

  belongs_to :kpi


  #validates :date, :value, presence: true

  validates_presence_of :value, :date

  validates :date, format: { with: /\d{4}[\/-]\d{1,2}[\/-]\d{1,2}/, message: "must be in format yyyy/mm/dd" }
  validates_numericality_of :date, message: "must be in date format (not text)"
  validates_numericality_of :value

  scope :get_wkvalue, -> (start) {where date: start if start.present?} 


  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |kpidatapoint|
        csv << kpidatapoint.attributes.values_at(*column_names)
      end
    end
  end

  #set method

  # def set_wkvalue(val,start)
  #   point = KpiDatapoint.where(date: start)
  #   point.value = val
  # end


  # def self.wkvalue(startdate)
  #  	find("date = ?", startdate)
  # end

  # def self.1wkvalue(startdate,kpi_id)
  #  	find("date = ?" and "kpi_id = ?", startdate, kpi_id)
  # end


  # kpi.kpi_datapoints.4wkvalues.average(:values).round(2)

  #scope :4wkvalues, ->(time) { where("reviews.created_at > ?", 4.week.ago) if time.present? }


end