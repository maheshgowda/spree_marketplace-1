Spree::Admin::ProductsController.class_eval do
  create.before :set_supplier

  private

  ##
  # Set current user as product supplier.
  def set_supplier
    @object.supplier = spree_current_user.supplier
  end
end
