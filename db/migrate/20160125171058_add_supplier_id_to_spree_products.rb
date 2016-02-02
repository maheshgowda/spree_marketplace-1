class AddSupplierIdToSpreeProducts < ActiveRecord::Migration
  def change
    add_reference :spree_products, :supplier, index: true, foreign_key: true
    Spree::Product.all.each do |product|
      product.update supplier: product.supplier
    end
  end
end
