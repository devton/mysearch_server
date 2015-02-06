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
          relevant_titles: parse_titles,
          relevant_paragraphs: parse_paragraph[0..2],
          another_texts: remaning_content,
          strongs: parse_strongs,
          page_title: @page.title,
          page_meta_tags: parse_meta_tags,
          page_description: @page.description.presence,
          images: parse_images
        }
    end

    def remaning_content
      collection = []
      collection.push(parse_titles('h4, h5, h6'))
      collection.push(parse_paragraph[3..-1])
      collection.flatten
    end

    def parse_titles selectors = 'h1, h2, h3'
      @page.parsed.css(selectors).map do |element|
        element.text.presence
      end.compact
    end

    def parse_paragraph
      @paragraphs ||= @page.parsed.css('p').map(&:text).compact
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
