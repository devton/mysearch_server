class CrawledUrl < ActiveRecord::Base
  def self.persist_from url
    self.find_or_create_by ::Crawler::UrlParser.parse(url) unless NegativeExpression.url_match?(url)
  end
end
