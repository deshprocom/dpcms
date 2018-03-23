class BaseUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  process resize_to_limit: [1080, nil]

  # rubocop:disable Style/GuardClause
  def crop
    if model.crop_x.present?
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop([[w, h].join('x'), [x, y].join('+')].join('+'))
      end
    end
  end
end
