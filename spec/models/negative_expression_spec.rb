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
end
