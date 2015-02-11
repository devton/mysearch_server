namespace :crawler do
  desc 'Start the crawler on a URL'
  task :start, [:url] => [:environment] do |t, args|
    Rails.logger.info "starting crawler on --> #{args[:url]}"
    links = Crawler::Web.collect_links_from args[:url]
    CrawledUrl.transaction do
      links.each do |url|
        CrawledUrl.persist_from url
      end
    end
  end
end
