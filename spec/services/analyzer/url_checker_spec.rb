require "rails_helper"

RSpec.describe Analyzer::UrlChecker, :type => :service do
  describe ".can_persist?" do
    subject { Analyzer::UrlChecker.can_persist? url }

    context "when url aleady persisted" do
      let(:url) { 'http://www.foo.bar.com' }

      before do
        attributes = ::Crawler::UrlParser.parse url
        create(:crawled_url, attributes)
      end

      it { is_expected.to be_falsy }
    end

    context "when url not persisted but is in negative expressions" do
      let(:url) { 'http://www.foo.bar.com/bad_url' }

      before do
        create(:negative_expression,{
          domains: ['www.foo.bar.com'],
          expressions: ['/bad*']
        })
      end

      it { is_expected.to be_falsy }
    end

    context "when url is not persisted and not have negative expression for he" do
      let(:url) { 'http://www.foo.bar.com' }
      it { is_expected.to be_truthy }
    end
  end
end
