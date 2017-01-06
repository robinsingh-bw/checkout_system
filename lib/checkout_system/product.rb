module CheckoutSystem
  class Product
    attr_reader :id, :name, :price

    def initialize(id, name, price)
      @id, @name, @price = id, name, price
    end
  end
end
