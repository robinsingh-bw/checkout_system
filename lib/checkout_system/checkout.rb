module CheckoutSystem
  class Checkout
    attr_accessor :line_item_promos, :order_promos, :line_items

    def initialize(promo_rules)
      self.line_item_promos = promo_rules.select{|rule| rule.requires_line_item? }
      self.order_promos = promo_rules.reject{|rule| rule.requires_line_item? }
      self.line_items = []
    end

    def scan(product)
      if li = line_items.find{ |li| li.product.id == product.id }
        li.increment_quantity
      else
        line_items << LineItem.new(product)
      end
    end

    def total
      item_total = line_items.inject(0) { |sum, li| sum + li.total }
      promo_total = 0

      # apply line item promotions first to get the discounted price
      line_items.each do |li|
        promo_total += line_item_promos.inject(0) { |sum, promo| sum + promo.compute(li, item_total) }
      end

      # apply order promos to discounted price
      promo_total += order_promos.inject(0) { |sum, promo| sum + promo.compute(nil, item_total - promo_total) }

      # return final discounted price rounded to 2 dp's
      (item_total - promo_total).round(2)
    end
  end
end
