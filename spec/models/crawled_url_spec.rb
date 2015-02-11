require 'rails_helper'

RSpec.describe CrawledUrl, :type => :model do
  describe ".persist_from" do
    let(:url) { 'http://www.foo.bar.com/foo-bar#lorem?ipsum=dolor' }
    let(:attributes) { ::Crawler::UrlParser.parse url }

    subject { CrawledUrl.persist_from url }

    context "when url already persisted" do
      let(:crawled_url) { create(:crawled_url, attributes) }
      before { crawled_url }

      it { is_expected.to eq(crawled_url) }
    end

    context "when url is not persisted" do
      it { is_expected.to be_an_instance_of(CrawledUrl) }
    end

    context "when url as negative expressions" do
      before do
        create(:negative_expression, {
          domains: ['www.foo.bar.com'],
          expressions: ['/foo-*']
        })
      end

      it { is_expected.to eq(nil) }
    end
  end
end
