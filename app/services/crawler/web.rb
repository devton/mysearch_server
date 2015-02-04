module Crawler
  class Web
    def self.index_from url
      _ = new url
      _.index!
    end

    def initialize url
      @url = url
    end

    def index!
      @request = follow_link

      if @request.response.status == 200
        ::CrawledUrl.persist_from @request.url
        collect_links_from_request
      end
    end

    protected

    def follow_link
      MetaInspector.new(@url, headers: { 'User-Agent' => 'mySearchServerCrawler'})
    end

    def collect_links_from_request
      @request.links.internal.each do |link|
        ::Crawler::Web.index_from(link) if Analyzer::UrlChecker.can_persist?(link)
      end
    end

  end
end
