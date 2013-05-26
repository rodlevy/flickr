class MyUploader < CarrierWave::Uploader::Base
  include CarrierWave
    storage :file

  def store_dir
    "uploads/images"
  end

process :resize_to_fit => [200, 200]


end
