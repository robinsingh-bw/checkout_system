# Applies a discount to the order total if it is more than the specified amount.
module CheckoutSystem
  module PromotionRules
    class Percent < PromotionRule
      attr_accessor :minimum_order_amount, :percent_multiplier

      def initialize(minimum_order_amount, percent_multiplier)
        self.minimum_order_amount = minimum_order_amount
        self.percent_multiplier = percent_multiplier
      end

      def requires_line_item?
        false
      end

      protected
        def eligible?(item, cart_total)
          cart_total > minimum_order_amount
        end

        def calculate_promo_total(item, cart_total)
          cart_total * percent_multiplier
        end
    end
  end
end
