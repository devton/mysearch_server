module Analyzer
  class UrlChecker
    def self.can_persist? url
      !CrawledUrl.already_persisted?(url) && !NegativeExpression.url_match?(url)
    end
  end
end
