require 'spec_helper'

describe Spree::Supplier do
  
  context '#active' do
    it 'returns of only active suppliers' do
      supplier = create(:supplier, active: true)
      inactive_supplier = create(:supplier, active: false)
      expect(Spree::Supplier.count).to eq 2
      expect(Spree::Supplier.active.count).to eq 1
    end
  end
  
  
end
