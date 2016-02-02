Spree::StockLocation.class_eval do

  # Wrapper for creating a new stock item respecting the backorderable config and supplier
  durably_decorate :propagate_variant, mode: 'soft', sha: 'f488d0a2cd154b1380cef9ee8c4db004fc825eb4' do |variant|
    if self.supplier_id.blank? || variant.supplier_id == self.supplier_id
      self.stock_items.create!(variant: variant, backorderable: self.backorderable_default)
    end
  end

end
