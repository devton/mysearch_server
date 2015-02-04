module Analyzer
  class UrlChecker
    def self.can_persist? url
      !CrawledUrl.already_persisted? url
    end
  end
end
