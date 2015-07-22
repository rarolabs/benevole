# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg mpeg png)
  end

  process :set_content_type

  version :thumb, if: :image? do
    process :resize_to_fill => [100, 100]
  end

  version :avatar, if: :image? do
    process :resize_to_fill => [48, 48]
  end

  version :timeline, if: :image? do
    process :resize_to_fill => [40, 40]
  end

  def jpg_name for_file, version_name
    %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.jpg}
  end

  protected
  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end
end
