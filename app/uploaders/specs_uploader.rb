class SpecsUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "#{Rails.root}#{Rails.configuration.uploads['location']}/assessments/#{model.id}"
  end
end
