module Crawler
  class Web
    attr_reader :valid_urls

    def self.collect_links_from url
      _ = new url
      _.collect_links!
      _.valid_urls.uniq
    end

    def initialize url
      uri = URI url
      @url = url
      @valid_urls = [url]
      @urls_buffer = []
      @host = uri.host
    end

    def collect_links!
      @request = follow_link
      process_buffer if @request && response_ok?
    end

    protected

    def process_buffer
      save_buffer
      @urls_buffer.each do |url|
        from_buffer = @urls_buffer.delete(url)

        puts "[web/crawler] - processing url #{from_buffer}"
        unless @valid_urls.include? from_buffer
          @valid_urls.push from_buffer
          @url = from_buffer
          puts "[web/crawler] - inserted #{from_buffer} into valid_urls"
          collect_links!
        end
      end
    end

    def save_buffer
      parsed_links = remove_query_from_links
      diff_links = parsed_links - @valid_urls
      @urls_buffer.concat(diff_links)
    end

    def remove_query_from_links
      @request.links.internal.map do |link|
        url = URI link
        url.query = nil
        url.to_s
      end
    end

    def response_ok?
      @request.response.status == 200
    end

    def follow_link url = @url
      uri = URI url
      return if uri.host != @host
      Rails.logger.info "[web/crawler] checking url -> #{uri}"
      MetaInspector.new(uri, headers: { 'User-Agent' => 'mySearchServerCrawler'})
    end

  end
end
