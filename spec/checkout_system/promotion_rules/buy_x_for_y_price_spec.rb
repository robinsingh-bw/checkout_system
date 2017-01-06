require "spec_helper"

describe CheckoutSystem::PromotionRules::BuyXForYPrice do
  let(:product) { CheckoutSystem::Product.new(1, 'Rails Jacket', 10) }
  let(:line_item) { CheckoutSystem::LineItem.new(product, 2) }
  let(:rule) { described_class.new(product.id, 2, 5) }

  before(:all) do
    described_class.send(:public, *described_class.protected_instance_methods)
  end

  describe '#eligible' do
    subject { rule.eligible?(line_item, 0) }

    it "should be true" do
      expect(subject).to be true
    end

    it "should be false if product id is different" do
      allow(rule).to receive(:product_id).and_return 2
      expect(subject).to be false
    end

    it "should be false if quantity is less than minimum quantity" do
      allow(rule).to receive(:minimum_quantity).and_return 10
      expect(subject).to be false
    end
  end

  describe '#calculate_promo_total' do
    subject { rule.calculate_promo_total(line_item, 0) }

    it "should return total discount amount" do
      expect(subject).to eq 10
    end
  end
end
