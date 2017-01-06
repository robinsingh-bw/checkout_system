require "spec_helper"

describe CheckoutSystem::PromotionRules::Percent do
  let(:product) { CheckoutSystem::Product.new(1, 'Rails Jacket', 10) }
  let(:line_item) { CheckoutSystem::LineItem.new(product, 2) }
  let(:rule) { described_class.new(10, 0.1) }

  before(:all) do
    described_class.send(:public, *described_class.protected_instance_methods)
  end

  describe '#eligible' do
    subject { rule.eligible?(nil, 20) }

    it "should be true" do
      expect(subject).to be true
    end

    it "should be false if cart total is less than minimum order total" do
      allow(rule).to receive(:minimum_order_amount).and_return 500
      expect(subject).to be false
    end
  end

  describe '#calculate_promo_total' do
    subject { rule.calculate_promo_total(line_item, 20) }

    it "should return total discount amount" do
      expect(subject).to eq 2
    end
  end
end
