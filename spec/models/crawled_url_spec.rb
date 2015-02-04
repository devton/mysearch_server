require 'rails_helper'

RSpec.describe CrawledUrl, :type => :model do
  describe ".find_for" do
    let(:url) { 'http://www.foo.bar.com' }
    let(:attributes) { ::Crawler::UrlParser.parse url }

    subject { CrawledUrl.find_for url }

    context "when url already persisted" do
      let(:crawled_url) { create(:crawled_url, attributes) }
      before { crawled_url }
      it { is_expected.to eq(crawled_url) }
    end

    context "when url is not persisted" do
      it { is_expected.to eq(nil) }
    end
  end

  describe ".persist_from" do
    let(:url) { 'http://www.foo.bar.com' }
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
  end

  describe ".already_persisted?" do
    let(:url) { 'http://www.foo.bar.com' }
    let(:attributes) { ::Crawler::UrlParser.parse url }

    subject { CrawledUrl.already_persisted? url }

    context "when url already persisted" do
      let(:crawled_url) { create(:crawled_url, attributes) }
      before { crawled_url }

      it { is_expected.to eq(true) }
    end

    context "when url is not persisted" do
      it { is_expected.to eq(false) }
    end
  end
end
