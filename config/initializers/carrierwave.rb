# Configure Carrierwave for testing
# @author Ashley Childress
# @version 3.1.2014
if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
  
  # make sure our uploader is auto-loaded
  ImageUploader

  # use different dirs when testing
  if defined?(CarrierWave)
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/test/support/uploads/tmp"
      end 

      def store_dir
        "#{Rails.root}/test/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end 
    end 
  end 
end
end