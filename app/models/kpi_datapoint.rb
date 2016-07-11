class KpiDatapoint < ActiveRecord::Base

  belongs_to :kpi


  validates :date, :value, presence: true

  validates_presence_of :value, :date

  validates :date, format: { with: /\d{4}[\/-]\d{1,2}[\/-]\d{1,2}/, message: "must be in format yyyy/mm/dd" }
  #validates_numericality_of :date, message: "must be in date format (not text)"
  validates_numericality_of :value

  scope :get_wkvalue, -> (start) {where date: start if start.present?} 
  scope :get_4wkvalues, -> {where("date > ?", 4.week.ago) }
  scope :get_thiswkvalue, -> {where("date = ?", 0.week.ago.beginning_of_week.to_date) }
  scope :get_1wkvalue, -> {where("date = ?", 1.week.ago.beginning_of_week.to_date) }


  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |kpidatapoint|
        csv << kpidatapoint.attributes.values_at(*column_names)
      end
    end
  end



  # def self.wkvalue(startdate)
  #  	find("date = ?", startdate)
  # end

  # def self.1wkvalue(startdate,kpi_id)
  #  	find("date = ?" and "kpi_id = ?", startdate, kpi_id)
  # end


  # kpi.kpi_datapoints.4wkvalues.average(:values).round(2)

  #scope :4wkvalues, ->(time) { where("reviews.created_at > ?", 4.week.ago) if time.present? }


end