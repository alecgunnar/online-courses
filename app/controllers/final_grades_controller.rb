require 'csv'

class FinalGradesController < ApplicationController
  before_action :force_instructor
  before_action :load_assessment
  before_action :load_final_grades

  EXPORT_DATA   = [['Student Name', 'name'], ['Student ID', 'id'], ['Grade', 'grade']]
  GRADE_FORMATS = [['Decimal (0.0 - 1.0)', 'decimal'], ['Percent (0% - 100%)', 'percent'], ['Fraction (Earned / Maximum)', 'fraction'], ['Points Earned', 'points']]
  FILE_FORMATS  = ['csv', 'json', 'yaml']

  def view
    @export_data    = EXPORT_DATA
    @grade_formats  = GRADE_FORMATS
    @file_formats   = FILE_FORMATS
  end

  def export
    options = export_params
    @data   = []

    @final_grades.map do |fg|
      data_hash = {}

      data_hash[:name] = fg.user.full_name if not options[:export_data].index('name').nil?
      data_hash[:id]   = fg.user.org_id if not options[:export_data].index('id').nil?

      if not options[:export_data].index('grade').nil?
        case options[:grade_format]
          when 'percent'
            data_hash[:grade] = "#{fg.decimal_result * 100}%"
          when 'fraction'
            data_hash[:grade] = "#{fg.submission.grade} / #{fg.assessment.points}"
          when 'points'
            data_hash[:grade] = "#{fg.submission.grade}"
          else
            data_hash[:grade] = fg.decimal_result
        end
      end

      @data << data_hash
    end

    send_data self.send("serialize_to_#{options[:file_format]}"), filename: "grades.#{options[:file_format]}", type: "text/#{options[:file_format]}"
  end

  private
    # Serializers for grade data
    def serialize_to_json
      @data.to_json
    end

    def serialize_to_csv
      return if not @data.length > 0

      CSV.generate do |csv|
        # This will give us a header row
        csv << @data[0].keys

        @data.each do |d|
          csv << d.values
        end
      end
    end

    def serialize_to_yaml
      @data.to_yaml
    end

    def load_assessment
      @assessment = Assessment.find_by_id params[:id]
      not_found if @assessment.nil?
    end

    def load_final_grades
      @final_grades = FinalGrade.where assessment: @assessment
    end

    def export_params
      params.permit :grade_format, :file_format, :export_data => []
    end
end
