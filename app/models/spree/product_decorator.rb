Spree::Product.class_eval do
  
  ##
  # This product belongs active supplier.
  def belongs_active_supplier?
    !supplier || supplier.active
  end

  ##
  # In marketplace unlike drop_ship product can belongs only one supplier.
  belongs_to :supplier
  
  ##
  # Search scope
  Spree::Product.add_search_scope :belongs_active_supplier do 
    joins('JOIN spree_suppliers on spree_products.supplier_id = spree_suppliers.id')
      .where 'spree_suppliers.active = ?', true
  end

  private

  def populate_for_supplier!(supplier)
    # Product can belongs only one supplier
    raise Error('Product already belongs other supplier') if self.supplier
    update supplier: supplier

    variants_including_master.each do |variant|
      unless variant.suppliers.pluck(:id).include?(supplier.id)
        variant.suppliers << supplier
        supplier.stock_locations.each { |loc| loc.set_up_stock_item(variant) }
      end
    end
  end
end
