require "rails_helper"

RSpec.describe Crawler::Web, :type => :service do
  describe ".index_from" do
    before do
      FakeWeb.register_uri(:get, %r|http://www\.my-search\.example\.com/|,
        body: <<-HTML
          <a href='/bad_url'>internal</a>
        HTML
      )
    end

    subject { ::CrawledUrl.find_for url }

    context "when a link is valid" do
      let(:url) { 'www.my-search.example.com' }

      before { Crawler::Web.index_from url }
      it { is_expected.not_to be_nil }
    end

    context "when a link match on negative expressions" do
      let(:url) { 'www.my-search.example.com/bad_url' }

      before do
        create(:negative_expression, {
          domains: ['www.my-search.example.com'],
          expressions: ['/bad*']
        })

        Crawler::Web.index_from url
      end
      it { is_expected.not_to be_nil }
    end
  end
end
