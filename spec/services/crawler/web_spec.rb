require "rails_helper"

RSpec.describe Crawler::Web, :type => :service do
  describe ".collect_links_from" do
    let(:collected_links) {
      [
        'http://www.example.com/page_link_1.html',
        'http://www.example.com/page_link_2.html',
        'http://www.example.com/page_link_3.html',
        'http://www.example.com/page_link_4.html',
      ]
    }

    before do
      1.upto(4).each do |i|
        FakeWeb.register_uri(:get, "http://www.example.com/page_link_#{i}.html", body: File.read(Rails.root + "spec/support/page_link_#{i}.html"))
      end
    end

    context "collect all internal url's from site" do
      subject { Crawler::Web.collect_links_from "http://www.example.com/page_link_1.html" }
      it { is_expected.to eq(collected_links)}
    end
  end
end
