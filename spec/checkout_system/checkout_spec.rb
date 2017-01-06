require "spec_helper"

describe CheckoutSystem::Checkout do
  let(:product) { CheckoutSystem::Product.new(1, 'Rails Jacket', 10) }
  let(:rule1) { CheckoutSystem::PromotionRules::BuyXForYPrice.new(product.id, 2, 5) }
  let(:rule2) { CheckoutSystem::PromotionRules::Percent.new(10, 0.1) }
  let(:checkout) { described_class.new([rule1, rule2]) }

  describe '#scan' do
    subject { checkout.scan(product) }

    it "should add new line item to array" do
      expect{subject}.to change{checkout.line_items.count}.by 1
    end

    it "should increment line item quantity if it already exists" do
      subject
      expect{checkout.scan(product)}.not_to change{checkout.line_items.count}
      expect(checkout.line_items.first.quantity).to eq 2
    end
  end

  describe '#total' do
    subject { checkout.total }

    before do
      checkout.scan(product)
      checkout.scan(product)
      checkout.scan(product)
      checkout.scan(product)
    end

    it "should return discounted price" do
      expect(subject).to eq ((product.price*4) - 20) * 0.9
    end
  end
end
