require "rails_helper"

RSpec.describe Crawler::Web, :type => :service do
  describe ".index_from" do
    before do
      FakeWeb.register_uri(:get, %r|http://www\.my-search\.example\.com/|, :body => "<a href='/internal_link'>internal</a>")
    end

    subject { ::CrawledUrl.find_for url }

    context "when a link is valid" do
      let(:url) { 'www.my-search.example.com' }

      before { Crawler::Web.index_from url }
      it { is_expected.not_to be_nil }
    end

    # TODO: need to create ah negative expressions table
    #context "when a link match on negative expressions" do
    #  let(:url) { 'www.my-search.example.com/badurl' }

    #  before { Crawler::Web.index_from url }
    #  it { is_expected.to be_nil }
    #end
  end
end
