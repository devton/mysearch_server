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

      it { is_expected.to eq(false) }
    end
  end
end
