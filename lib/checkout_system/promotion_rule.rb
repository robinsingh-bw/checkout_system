module CheckoutSystem
  class PromotionRule
    def compute(item, cart_total)
      return 0 unless eligible?(item, cart_total)
      calculate_promo_total(item, cart_total)
    end

    def requires_line_item?
      false
    end

    protected
      def eligible?(item, cart_total)
        false
      end

      def calculate_promo_total(item, cart_total)
        0
      end
  end
end
