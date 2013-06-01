$redis = Redis.new(:host => Rails.configuration.redis_host, :port => Rails.configuration.redis_port)
