if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider = 'AWS'
    config.fog_directory = 'aws-test-rails'
    config.aws_access_key_id = ENV.fetch('AWS_ACCESS_KEY_ID', nil)
    config.aws_secret_access_key = ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
    config.aws_session_token = ENV['AWS_SESSION_TOKEN'] if ENV.key?('AWS_SESSION_TOKEN')
    config.fog_region = 'ap-northeast-1'
    config.run_on_precompile = false
    config.add_local_file_paths do
      public_root = Rails.root.join('public')
      Dir.chdir(public_root) do
        packs_dir = Webpacker.config.public_output_path.relative_path_from(public_root)
        Dir[File.join(packs_dir, '/**/**')]
      end
    end
  end
end
