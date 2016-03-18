class TestDriverUploader < CarrierWave::Uploader::Base
  storage :file
  
  def store_dir
    "#{Rails.root}#{Rails.configuration.uploads['location']}/assessment/#{model.assessment.id}/test_drivers/#{model.id}"
  end
end
