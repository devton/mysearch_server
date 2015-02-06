require 'rails_helper'

RSpec.describe NegativeExpression, :type => :model do

  describe ".expressions_for" do
    subject { NegativeExpression.expressions_for 'example.com' }

    context "should get expressions" do
      context "when have a domain expression" do
        before do
          create(:negative_expression,{
            domains: ['www.example.com', 'example.com']
          })

          create(:negative_expression,{
            domains: ['www.example2.com']
          })
        end
        it { expect(subject.size).to eq(1) }
      end

      context "when don't have a domain expression" do
        it { expect(subject.size).to eq(0) }
      end
    end
  end

  describe ".with_regex" do
    subject { NegativeExpression.with_path_regex path }
    context "get all expressions that match with regex" do
      let(:path) { '/foo_bar' }

      context "when regex matches" do
        before do
          create(:negative_expression,{
            domains: ['www.example.com'],
            expressions: ['/fo*']
          })
        end

        it { expect(subject.size).to eq(1) }
      end

      context "when regex don't matches" do
        before do
          create(:negative_expression,{
            domains: ['www.example.com'],
            expressions: ['/fooo_bar']
          })
        end
        it { expect(subject.size).to eq(0) }
      end
    end
  end

  describe ".url_match?" do
    subject { NegativeExpression.url_match? url }

    before do
      create(:negative_expression,{
        domains: ['www.example.com'],
        expressions: ['/bad*']
      })
    end

    context "when url matches with a negative expression" do
      let(:url) { 'www.example.com/bad_url-foo' }
      it { is_expected.to be_truthy }
    end

    context "when url don't matches with a negative expression" do
      let(:url) { 'www.example.com/good_url' }
      it { is_expected.to be_falsy }
    end
  end
end
