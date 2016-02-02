module Spree
  Variant.class_eval do

    delegate :supplier, to: :product

    def suppliers
      raise NoMethodError
    end

    def supplier_variants
      raise NoMethodError
    end

    private
    
      durably_decorate :create_stock_items, mode: 'soft', sha: '4701b8f5d9ff4f3e13913c64a590f336f4962dbe' do
        StockLocation.all.each do |stock_location|
          if stock_location.supplier_id.blank? || self.product.supplier_id == stock_location.supplier_id
            stock_location.propagate_variant(self) if stock_location.propagate_all_variants?
          end
        end
      end

      def populate_for_suppliers; end
  end
end
