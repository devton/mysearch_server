require "rails_helper"

RSpec.describe Crawler::Recorder, :type => :service do
  describe ".collect_links_from" do
    let(:collected_links) {
      [
        'http://www.example.com/page_link_1.html',
        'http://www.example.com/page_link_2.html',
        'http://www.example.com/page_link_3.html',
        'http://www.example.com/page_link_4.html',
      ]
    }


    context "when don't have any negative expressions" do
      before { Crawler::Recorder.persist_from collected_links }
      it { expect(CrawledUrl.count).to eq(4) }
    end

    context "when have a negative expression" do
      before do
        create(:negative_expression, {
          domains: ['www.example.com'],
          expressions: [
            '/page_link_4.html'
          ]
        })
        Crawler::Recorder.persist_from collected_links
      end

      it { expect(CrawledUrl.count).to eq(3) }
    end
  end
end
