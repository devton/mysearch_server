module Crawler
  class Web
    attr_reader

    def self.collect_links_from url
      _ = new url
      _.collect_links!
      _.get_valid_urls
    end

    def initialize url
      @url = URI url
      @host = @url.host

      build_redis_collections
    end

    def collect_links!
      @request = follow_link
      process_buffer if @request && response_ok?
    end

    def valid_urls_key
      "#{@host}_valid_urls"
    end

    def urls_buffer_key
      "#{@host}_urls_buffer"
    end

    def get_valid_urls
      JSON.parse $redis.get(valid_urls_key)
    end

    def get_urls_buffer
      JSON.parse $redis.get(urls_buffer_key)
    end

    protected

    def build_redis_collections
      $redis.set(valid_urls_key, [@url.to_s].to_json)
      $redis.set(urls_buffer_key, [].to_json)
    end

    def process_buffer
      add_to_buffer links_without_query - get_valid_urls
      buffer = get_urls_buffer

      get_urls_buffer.each do |url|
        from_buffer = buffer.delete(url)

        Rails.logger.info "[web/crawler] - processing url #{from_buffer}"
        unless get_valid_urls.include? from_buffer
          add_to_valid_urls [from_buffer]
          @url = from_buffer
          Rails.logger.info "[web/crawler] - inserted #{from_buffer} into valid_urls"
          collect_links!
        end
      end
    end

    def add_to_valid_urls links
      urls = get_valid_urls
      $redis.set(valid_urls_key, urls.concat(links - urls))
    end

    def add_to_buffer links
      buffer = get_urls_buffer
      $redis.set(urls_buffer_key, buffer.concat(links - buffer))
    end

    def links_without_query
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
