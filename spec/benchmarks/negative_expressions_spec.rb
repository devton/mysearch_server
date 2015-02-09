require 'rails_helper'

class FakeNegativeExpression < NegativeExpression
  def self.url_match_on_ruby? url
    uri = URI url
    expressions = expressions_for(uri.host)#.with_path_regex(uri.path).exists?
    expressions.pluck(:expressions).flatten.any? do |expression|
      uri.path.match expression
    end
  end
end


RSpec.describe FakeNegativeExpression, :type => :performance do
  before do
    require 'benchmark'
  end

  describe "Benchmark for url_match?" do
    before do
      2_000.times do |i|
        create(:negative_expression, {
          domains: ['www.example.com', "www.#{i}.com"],
          expressions: (1..10).map { |i| "/#{i}/page*" }
        })
      end
    end

    it "Takes time" do
      Benchmark.bm do |x|
        x.report("PostgreSQL") do
          10.times do
            FakeNegativeExpression.url_match? 'http://www.example.com'
          end
        end

        x.report("Ruby") do
          10.times do
            FakeNegativeExpression.url_match_on_ruby? 'http://www.example.com'
          end
        end
      end
    end
  end
end
