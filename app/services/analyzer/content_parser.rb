module Analyzer
  class ContentParser
    def self.fetch_content_from url
      _ = new url
      _.fetch_data
    end

    def initialize url
      @url = url
    end

    def fetch_data
      @page ||= MetaInspector.new(@url)
      build_hash if @page.response.status == 200
    end

    protected

    def build_hash
        {
          titles: parse_titles,
          paragraphs: parse_paragraph,
          strongs: parse_strongs,
          page_title: @page.title,
          page_meta_tags: parse_meta_tags,
          page_description: @page.description.presence,
          images: parse_images
        }
    end

    def parse_titles
      @page.parsed.css('h1, h2, h3, h4, h5, h6').map do |element|
        element.text.presence
      end.compact
    end

    def parse_paragraph
      @page.parsed.css('p').map(&:text).compact
    end

    def parse_strongs
      @page.parsed.css('strong').map(&:text).compact
    end

    def parse_images
      @page.images.to_a if @page.images.to_a.present?
    end

    def parse_meta_tags
      keys = @page.meta_tag['name'].try(:[], 'keywords').try(:split, ',')
      keys.map(&:strip)
    end
  end
end
