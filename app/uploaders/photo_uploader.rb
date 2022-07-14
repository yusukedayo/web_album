# frozen_string_literal: true

class PhotoUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
  # ＃process resize_to_fit: [150, 150]
# ＃
  version :ablum_photo do
    process resize_to_fit: [400, 500]
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def secure_token
    media_original_filenames_var = :"@#{mounted_as}_original_filenames"

    model.instance_variable_set(media_original_filenames_var, {}) unless model.instance_variable_get(media_original_filenames_var)

    unless model.instance_variable_get(media_original_filenames_var).map { |k, _v| k }.include? original_filename.to_sym
      new_value = model.instance_variable_get(media_original_filenames_var).merge({ "#{original_filename}": SecureRandom.uuid })
      model.instance_variable_set(media_original_filenames_var, new_value)
    end

    model.instance_variable_get(media_original_filenames_var)[original_filename.to_sym]
  end
end
