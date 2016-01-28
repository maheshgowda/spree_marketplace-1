class RemoveSpreeSupplierVariants < ActiveRecord::Migration
  def change
    drop_table :spree_supplier_variants
  end
end
