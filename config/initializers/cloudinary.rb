Cloudinary.config do |config|
  config.cloud_name = ENV['CLOUDINARY_CLOUD_NAME'] || 'hpjjdchal'
  config.api_key = ENV['CLOUDINARY_API_KEY'] || '817456671593443'
  config.api_secret = ENV['CLOUDINARY_API_SECRET'] || 'Nj7vDsPaVSWLB_-HsImAsxt4neg'
  config.cdn_subdomain = true
end
