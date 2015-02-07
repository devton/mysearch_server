module Crawler
  class Recorder
    def self.persist_from links
      links.each do |link|
        if Analyzer::UrlChecker.can_persist?(link)
          Rails.logger.info '[recorder/crawler] -> persisting #{link}'
          CrawledUrl.persist_from(link)
        end
      end
    end
  end
end