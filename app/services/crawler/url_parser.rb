module Crawler
  class UrlParser
    def self.parse url
      _ = new url
      _.parse!
    end

    def initialize url
      @url = URI url
      @url = URI 'http://' + url unless url.starts_with? 'http://', 'https://'
    end

    def parse!
      build_hash
    end

    protected

    def build_hash
      {
        url_scheme: @url.scheme,
        host: @url.host,
        path: url_path,
        fragment: url_fragment,
        query_strings: url_queries
      }
    end

    def url_path
      return "/" if @url.path.blank?
      @url.path
    end

    def url_fragment
      if @url.fragment.present?
        @fragment, @queries = @url.fragment.split('?')
        '#' + @fragment
      end
    end

    def url_queries
      @queries ||= @url.query

      if @queries
        ordered_queries = CGI.parse(@queries)
        @queries = ordered_queries.keys.sort.map do |x|
          "#{x}=#{ordered_queries[x][0]}"
        end
      end
    rescue
      nil
    end
  end
end
