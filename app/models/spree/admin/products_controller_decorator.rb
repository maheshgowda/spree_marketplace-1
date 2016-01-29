Spree::Admin::ProductsController.class_eval do
  private
  
  ##
  # Overrides DripShip method. DropShip executes this method before
  # 'index' action.
  # Scopes the collection to the Supplier.
  def supplier_collection
    show_only_supplier_products = try_spree_current_user &&
                                  !try_spree_current_user.admin? &&
                                  try_spree_current_user.supplier?
    if show_only_supplier_products
      @collection = 
        @collection.where(supplier_id: try_spree_current_user.supplier_id)
    end
  end
end
