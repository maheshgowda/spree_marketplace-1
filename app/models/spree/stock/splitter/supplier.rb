module Spree
  module Stock
    module Splitter
      ##
      # Associate each inventory unit in order with supplier's stock location.
      # Spree does not know about suppliers and uses any stock location.
      # DropShip plugin uses stock location of any supplier having this variant.
      # In our marketplace variant can only belongs to use supplier.
      class Supplier < Spree::Stock::Splitter::Base
        def split(packages)
          split_packages = []
          packages.each do |package|
            # Package fulfilled items together.
            fulfilled = package.contents.select { |content| !content.variant.supplier }
            split_packages << build_package(fulfilled)
            # Determine which supplier to package drop shipped items.
            drop_ship = package.contents.select { |content| content.variant.supplier }
            drop_ship.each do |content|
              # Select the related variant
              variant = content.variant
              # Select first supplier that has stock location with avialable stock item.
              supplier = variant.supplier
              # Select the first available stock location with in the supplier stock locations.
              stock_location = 
                supplier.stock_locations_with_available_stock_items(variant).first
              stock_location = 
                supplier.stock_locations.first unless stock_location 
              # Add to any existing packages or create a new one.
              existing_package =
                split_packages.detect { |p| p.stock_location == stock_location }
                
              if existing_package
                existing_package.contents << content
              else
                split_packages << Spree::Stock::Package.new(stock_location, [content])
              end
            end
          end
          return_next split_packages
        end
      end
    end
  end
end
