require 'open-uri'

namespace :benchmarks do
  desc 'MetaInspector vs Nokogiri'
  task metagiri: :environment do
    html = (1..1_000).inject("") { |t, i| t += "<a href='/page_#{i}.html'>link to page_#{i}</a>" }
    FakeWeb.register_uri(:get, "http://example.com", body: html)

    Benchmark.bm do |x|
      x.report("MetaInspector:") do
        page = MetaInspector.new('http://example.com')
        page.links.all
      end

      x.report("Nokogiri #xpath:") do
        page = Nokogiri::HTML(open('http://example.com'))
        page.xpath('//a/@href').map { |node| node['href'] }
      end

      x.report("Nokogiri #css") do
        page = Nokogiri::HTML(open('http://example.com'))
        page.css('a').map { |node| node['href'] }
      end

      x.report("Nokogiri #search") do
        page = Nokogiri::HTML(open('http://example.com'))
        page.search('//a/@href').map { |node| node['href'] }
      end
    end
  end
end
