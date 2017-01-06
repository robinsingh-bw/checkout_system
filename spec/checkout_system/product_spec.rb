require "spec_helper"

describe CheckoutSystem::Product do
  let(:product) { described_class.new(1, 'Rails Jacket', 25.99) }

  it "has an id" do
    expect(product.id).to eq 1
  end

  it "has a name" do
    expect(product.name).to eq 'Rails Jacket'
  end

  it "has a price" do
    expect(product.price).to eq 25.99
  end
end
