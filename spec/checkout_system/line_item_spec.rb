require "spec_helper"

describe CheckoutSystem::LineItem do
  let(:product) { CheckoutSystem::Product.new(1, 'Rails Jacket', 25.99) }
  let(:line_item) { described_class.new(product, 2) }

  describe '#increment_quantity' do
    subject { line_item.increment_quantity }

    it "should increase the quantity by 1" do
      expect{subject}.to change{line_item.quantity}.by 1
    end
  end

  describe '#total' do
    subject { line_item.total }

    it "should calculate the total price for the line item" do
      expect(subject).to eq 25.99 * 2
    end
  end
end
