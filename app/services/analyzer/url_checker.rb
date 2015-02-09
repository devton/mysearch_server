module Analyzer
  class UrlChecker
    def self.valid? url
      !CrawledUrl.already_persisted?(url) && !NegativeExpression.url_match?(url)
    end
  end
end
