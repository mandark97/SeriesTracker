Rails.application.configure do
  config.cache_classes = false
  config.eager_load = true
  config.consider_all_requests_local = true
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.quiet = true
  ENV['SECRET_KEY_BASE'] = Rails.application.secrets.secret_key_base
  ENV['TWITTER_API_KEY'] = Rails.application.secrets.twitter_api_key
  ENV['TWITTER_API_SECRET'] = Rails.application.secrets.twitter_api_secret
  ENV['OMDB_API_KEY'] = Rails.application.secrets.omdb_api_key
end
