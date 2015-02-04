class CrawledUrl < ActiveRecord::Base
  def self.find_for url, parser = ::Crawler::UrlParser
    self.find_by parser.parse(url)
  end

  def self.persist_from url, parser = ::Crawler::UrlParser
    self.find_or_create_by parser.parse(url)
  end

  def self.already_persisted? url, parser = ::Crawler::UrlParser
    where(parser.parse(url)).exists?
  end
end
