CarrierWave.configure do |config|
  #unless ENV['AWS_ACCESS_KEY_ID'].blank?
	  config.fog_provider = 'fog/aws'
	  config.fog_credentials = {
	    :provider               => 'AWS',                        # required
	    :aws_access_key_id      => ENV["AWS_ACCESS_KEY_ID"],                        # required
	    :aws_secret_access_key  => ENV["AWS_SECRET_ACCESS_KEY"], 
	    :region 				=> 'us-east-1'                        # required
	  }
	  config.fog_directory  = ENV["fog_directory"]                    # required
	#end
end