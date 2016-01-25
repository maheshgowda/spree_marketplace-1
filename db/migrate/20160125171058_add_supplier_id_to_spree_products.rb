class AddSupplierIdToSpreeProducts < ActiveRecord::Migration
  def change
    add_reference :spree_products, :supplier, index: true, foreign_key: true
    Spree::Product.each do |product|
      product.update supplier: product.suppliers.first
    end
  end
end
