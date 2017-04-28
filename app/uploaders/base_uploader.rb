class BaseUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::MiniMagick
  include CarrierWave::ImageOptim

  storage :file
  process :resize_to_limit => [900, nil]
  # process :optimize

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

  def extension_white_list
    %w(jpg jpeg gif png svg)
  end

  def filename
    today = Date.today
    # current_path 是 Carrierwave 上传过程临时创建的一个文件，有时间标记，所以它将是唯一的
    @name ||= Digest::MD5.hexdigest(current_path)
    "#{today.strftime("%Y/%m")}/#{@name}.#{file.extension.downcase}"
  end
end
