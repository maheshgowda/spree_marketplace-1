require 'spec_helper'

describe Spree::Product do
  context '#active?' do
    it 'returns true for active suppliers only' do
      supplier = create(:supplier, active: true)
      inactive_supplier = create(:supplier, active: false)
      
      product = create(:product)
      product.add_supplier! supplier

      inactive_product = create(:product)
      inactive_product.add_supplier! inactive_supplier
      
      expect(product.active?).to eq true
      expect(inactive_product.active?).to eq false
    end
  end
end
