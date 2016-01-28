module Spree
  Variant.class_eval do

    delegate :supplier, to: :product

    private

    def populate_for_suppliers;
      raise 'aaaa'
    end

  end
end
