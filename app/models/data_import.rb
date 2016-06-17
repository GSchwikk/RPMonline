class DataImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_data.map(&:valid?).all?
      imported_data.each(&:save!)
      true
    else
      imported_data.each_with_index do |datapoint, index|
        datapoint.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end


  def imported_data
    @imported_data ||= load_imported_data
  end


  def load_imported_data
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    kpidatapoints = []
    kpidatapoints.clear
    (2..spreadsheet.last_row).each_with_index do |i,rowindex|
      row = spreadsheet.row(i)
      if Kpi.find_by_id(row[0])
        kpi = Kpi.find_by_id(row[0])
        (3..spreadsheet.last_column).each_with_index do |j,colindex|

          kpidatapoint = kpi.kpi_datapoints.get_wkvalue(header[colindex+2]).first || kpi.kpi_datapoints.build
          kpidatapoint.value = row[colindex+2]
          kpidatapoint.date = header[colindex+2]
          kpidatapoints << kpidatapoint

        end
      end
    end
    return kpidatapoints
  end




  def open_spreadsheet
    case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end


end