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
      request = follow_link

      if request.response.status == 200
        ::CrawledUrl.persist_from request.url
      end
    end

    protected

    def follow_link
      MetaInspector.new(@url, headers: { 'User-Agent' => 'mySearchServerCrawler'})
    end

  end
end
