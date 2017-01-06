module CheckoutSystem
  class LineItem
    attr_reader :product, :quantity

    def initialize(product, quantity=1)
      @product, @quantity = product, quantity
    end

    def increment_quantity
      @quantity += 1
    end

    def total
      @product.price * @quantity
    end
  end
end
