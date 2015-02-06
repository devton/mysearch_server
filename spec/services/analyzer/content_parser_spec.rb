require "rails_helper"

RSpec.describe Analyzer::ContentParser, :type => :service do
  describe ".fetch_from_url" do
    before do
      FakeWeb.register_uri(:get, %r|http://www\.example\.com/|,
        body: <<-HTML
          <html>
            <head>
              <title>Page title</title>
              <meta name='keywords' content="meta, tags" />
            </head>
            <body>
              <h1>Lorem ipsum dolor</h1>
              <h3>Foo bar</h3>
              <br/><br/>
              <p>Lorem ipsum dolo sit amet consectetuir <strong>Foo barrr</strong></p>
            </body>
          </html>
        HTML
      )
    end

    subject { Analyzer::ContentParser.fetch_content_from url }

    context "when page is online" do
      let(:url) { 'www.example.com' }
      let(:parsed_hash) {
        {
          titles: ['Lorem ipsum dolor', 'Foo bar'],
          paragraphs: ['Lorem ipsum dolo sit amet consectetuir Foo barrr'],
          strongs: ['Foo barrr'],
          page_title: 'Page title',
          page_meta_tags: ['meta', 'tags'],
          page_description: nil,
          images: nil
        }
      }
      it { is_expected.to eq(parsed_hash)}
    end
  end
end
