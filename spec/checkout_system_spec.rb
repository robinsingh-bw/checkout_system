require "spec_helper"

describe CheckoutSystem do
  describe 'the_test' do
    let(:p1) { CheckoutSystem::Product.new(1, 'Lavender heart', 9.25) }
    let(:p2) { CheckoutSystem::Product.new(2, 'Personalised cufflinks', 45.00) }
    let(:p3) { CheckoutSystem::Product.new(3, 'Kids T-shirt', 19.95) }
    let(:rule1) { CheckoutSystem::PromotionRules::BuyXForYPrice.new(p1.id, 2, 8.50) }
    let(:rule2) { CheckoutSystem::PromotionRules::Percent.new(60, 0.1) }
    let(:promotional_rules) { [rule1, rule2] }
    let(:co) { CheckoutSystem::Checkout.new(promotional_rules) }

    it "should return a total price of 66.78" do
      co.scan(p1)
      co.scan(p2)
      co.scan(p3)
      expect(co.total).to eq 66.78
    end

    it "should return a total price of 36.95" do
      co.scan(p1)
      co.scan(p3)
      co.scan(p1)
      expect(co.total).to eq 36.95
    end

    it "should return a total price of 73.76" do
      co.scan(p1)
      co.scan(p2)
      co.scan(p1)
      co.scan(p3)
      expect(co.total).to eq 73.76
    end
  end
end
