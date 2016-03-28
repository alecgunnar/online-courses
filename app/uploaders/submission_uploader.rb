class SubmissionUploader < CarrierWave::Uploader::Base
  storage :file
  
  def store_dir
  	"#{Rails.root}#{Rails.configuration.uploads['location']}/assessments/#{model.assessment.id}/submissions/#{model.id}"
  end
end
