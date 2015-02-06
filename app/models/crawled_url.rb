class CrawledUrl < ActiveRecord::Base
  URL_PARSER = ::Crawler::UrlParser

  def self.find_for url, parser = URL_PARSER
    self.find_by parser.parse(url)
  end

  def self.persist_from url, parser = URL_PARSER
    self.find_or_create_by parser.parse(url)
  end

  def self.already_persisted? url, parser = URL_PARSER
    where(parser.parse(url)).exists?
  end
end
