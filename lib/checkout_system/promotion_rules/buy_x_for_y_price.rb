# Applies a discount if a product is added more times than the minimum quantity.
module CheckoutSystem
  module PromotionRules
    class BuyXForYPrice < PromotionRule
      attr_accessor :product_id, :minimum_quantity, :new_price

      def initialize(product_id, minimum_quantity, new_price)
        self.product_id = product_id
        self.minimum_quantity = minimum_quantity
        self.new_price = new_price
      end

      def requires_line_item?
        true
      end

      protected
        def eligible?(line_item, cart_total)
          product_id == line_item.product.id && line_item.quantity >= minimum_quantity
        end

        def calculate_promo_total(line_item, cart_total)
          (line_item.product.price - new_price) * line_item.quantity
        end
    end
  end
end
