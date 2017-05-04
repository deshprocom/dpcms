class RacePhotoUploader < BaseUploader
  process resize_to_limit: [900, nil]

  version :preview do
    process resize_to_fit: [200, 200]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    @name ||= Digest::MD5.hexdigest("#{super}#{Time.now}")
    "#{@name}.#{file.extension.downcase}"
  end
end
