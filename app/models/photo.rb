class Photo < ActiveRecord::Base
  belongs_to :album
  mount_uploader :file, MyUploader

  def photo_url
    self.file.url.gsub(/.*public/,'')
  end


end
