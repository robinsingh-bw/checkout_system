require "spec_helper"

describe CheckoutSystem::PromotionRule do
  let(:rule) { described_class.new }

  describe '#compute' do
    subject { rule.compute(nil, 50) }

    before do
      allow(rule).to receive(:calculate_promo_total).and_return 10
    end

    it "should return the computed promo total" do
      allow(rule).to receive(:eligible?).and_return true
      expect(subject).to eq 10
    end

    it "should return 0 if not eligible" do
      allow(rule).to receive(:eligible?).and_return false
      expect(subject).to eq 0
    end
  end
end
