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

  def self.belongs_to_supplier(supplier)
    where supplier: supplier
  end
  
  search_scopes << :belongs_to_supplier
  
  private

  def populate_for_supplier!(supplier)
    # Product can belongs only one supplier
    raise Error('Product already belongs other supplier') if self.supplier
    update supplier: supplier
  end
end
