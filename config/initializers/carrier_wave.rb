require 'carrierwave/orm/activerecord'
# if Rails.env.test? || Rails.env.cucumber?
#   CarrierWave.configure do |config|
#     config.storage = :file
#     config.enable_processing = false
#   end
#
#   # make sure our uploader is auto-loaded
#   # MyAvatarUploader
#
#   # use different dirs when testing
#   CarrierWave::Uploader::Base.descendants.each do |klass|
#     next if klass.anonymous?
#     klass.class_eval do
#       storage :file
#
#       def store_dir
#         "#{Rails.root}/spec/support/images/test/"
#       end
#     end
#   end
# end
