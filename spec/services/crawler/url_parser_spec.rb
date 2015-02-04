require "rails_helper"

RSpec.describe Crawler::UrlParser, :type => :service do
  describe ".parse" do
    subject { Crawler::UrlParser.parse url }

    context "normal url" do
      let(:url) { 'www.my-example.url.com' }
      let(:url_attributes) {
        {
          url_scheme: 'http',
          host: 'www.my-example.url.com',
          path: '/',
          fragment: nil,
          query_strings: nil
        }
      }

      it { is_expected.to eq(url_attributes) }
    end

    context "with fragments" do
      let(:url) { 'www.my-example.url.com/#!/foo/bar' }
      let(:url_attributes) {
        {
          url_scheme: 'http',
          host: 'www.my-example.url.com',
          path: '/',
          fragment: '#!/foo/bar',
          query_strings: nil
        }
      }
      it { is_expected.to eq(url_attributes) }
    end

    context "with query strings" do
      let(:url) { 'www.my-example.url.com/?foo=bar&bar=foo' }
      let(:url_attributes) {
        {
          url_scheme: 'http',
          host: 'www.my-example.url.com',
          path: '/',
          fragment: nil,
          query_strings: ['bar=foo', 'foo=bar']
        }
      }
      it { is_expected.to eq(url_attributes) }
    end

    context "complex with query and fragments" do
      let(:url) { 'www.my-example.url.com/#!/foo/bar?foo=bar&bar=foo' }
      let(:url_attributes) {
        {
          url_scheme: 'http',
          host: 'www.my-example.url.com',
          path: '/',
          fragment: '#!/foo/bar',
          query_strings: ['bar=foo', 'foo=bar']
        }
      }
      it { is_expected.to eq(url_attributes) }
    end
  end
end
