namespace :crawler do
  desc 'Start the crawler on a URL'
  task :start, [:url] => [:environment] do |t, args|
    Rails.logger.info "starting crawler on --> #{args[:url]}"
    Crawler::Web.collect_links_from args[:url]
  end
end
