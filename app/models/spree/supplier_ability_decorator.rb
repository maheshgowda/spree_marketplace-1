Spree::SupplierAbility.class_eval do

    def initialize(user)

      user ||= Spree.user_class.new

      if user.supplier

        can [:admin, :manage, :stock], Spree::Product do |product|
          product.supplier == user.supplier
        end

        can [:admin, :manage, :stock], Spree::Variant do |variant|
          variant.product.supplier == user.supplier
        end

        can [:admin, :manage], Spree::Image do |image|
          image.viewable && 
            image.viewable.supplier_ids.include?(user.supplier_id)
        end

        can [:modify], Spree::Classification do |classification|
          classification.product.supplier_id = user.supplier_id
        end
        can [:modify], Spree::OptionType do |option|
          option.suppliers.exists?(user.supplier_id)
        end
        
        
        # TODO Check image viewable
        can [:create], Spree::Image

        can [:create], Spree::Product do |product|
          user.supplier?
        end
        
        can [:create], Spree::Variant do |variant|
          variant.product.supplier_id == user.supplier_id
        end

        can [:admin, :show], Spree::Prototype
        can [:admin, :update], Spree::ProductProperty do |property|
          property.product.supplier_id == user.supplier_id
        end

        can [:admin, :update], Spree::Price

        can [:admin], Spree::Variant
        can [:admin, :index], Spree::Product
        can [:admin, :manage, :read, :ready, :ship],
            Spree::Shipment,
            order: { state: 'complete' },
            stock_location: { supplier_id: user.supplier_id }
        can [:admin, :create, :update], :stock_items
        can [:admin, :manage],
            Spree::StockItem,
            stock_location_id: user.supplier.stock_locations.pluck(:id)
        can [:admin, :manage],
            Spree::StockLocation,
            supplier_id: user.supplier_id
        can :create, Spree::StockLocation
        can [:admin, :manage],
            Spree::StockMovement,
            stock_item: {
              stock_location_id: user.supplier.stock_locations.pluck(:id)
            }
        can :create, Spree::StockMovement
        can [:admin, :update], Spree::Supplier, id: user.supplier_id
      end



    end

end
