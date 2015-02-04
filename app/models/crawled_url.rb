class CrawledUrl < ActiveRecord::Base
  def self.find_for url
    attributes = ::Crawler::UrlParser.parse url
    self.find_by attributes
  end

  def self.persist_from url
    attributes = ::Crawler::UrlParser.parse url
    self.find_or_create_by attributes
  end
end
