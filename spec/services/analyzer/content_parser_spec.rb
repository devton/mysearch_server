require "rails_helper"

RSpec.describe Analyzer::ContentParser, :type => :service do
  describe ".fetch_from_url" do
    before do
      FakeWeb.register_uri(:get, %r|http://www\.example\.com/|, body: File.read(Rails.root + "spec/support/example_page.html"))
    end

    subject { Analyzer::ContentParser.fetch_content_from url }

    context "when page is online" do
      let(:url) { 'www.example.com' }
      let(:parsed_hash) {
        {
          relevant_titles: [
            'lorem ipsum h1',
            'lorem ipsum h2 with span',
            'lorem ipsum h3 with strong'],
          relevant_paragraphs: [
            'lorem 1 p',
            'lorem 2 p',
            'lorem 3 p'
          ],
          another_texts: [
            'lorem ipsum h4',
            'lorem ipsum h5',
            'lorem ipsum h6',
            'lorem 4 p',
            'lorem 5 p'
          ],
          strongs: ['with strong', 'foo bar strong'],
          page_title: 'Page title',
          page_meta_tags: ['meta', 'tags'],
          page_description: 'page description',
          images: ['http://www.example.com/foo.png']
        }
      }
      it { is_expected.to eq(parsed_hash)}
    end
  end
end
