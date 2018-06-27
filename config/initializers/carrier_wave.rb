require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
    config.storage                             = :gcloud
    config.gcloud_bucket                       = 'nycsnaps'
    config.gcloud_bucket_is_public             = true
    config.gcloud_authenticated_url_expiration = 600
    
    config.gcloud_attributes = {
      expires: 600
    }
    
    config.gcloud_credentials = {
      gcloud_project: 'NYCsnaps',
      gcloud_keyfile: 'My First Project-e5a7b719c54b.json'
    }
  end