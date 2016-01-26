module Spree
  class SupplierController < Spree::BaseController
    before_action :load_model, only: [:show, :products]
    helper_method :products_of_supplier
    
    ##
    # Page with list of all suppliers.
    def index
      @suppliers = Spree::Supplier.active
    end
    
    ##
    # Page for registration new supplier.
    def new
      @supplier = Spree::Supplier.new
    end
    
    def create
      perm_params = permit_params
      @supplier = Spree::Supplier.create(perm_params)
      if @supplier.errors.empty?
        spree_current_user.supplier = @supplier
        spree_current_user.save!
        redirect_to edit_admin_supplier_path(@supplier) 
      else
        render :new
      end
    end

    private
    
    def products_of_supplier(supplier)
      searcher = build_searcher(params.merge(include_images: true))
      # Add belongs_to_supplier to search filter. Need refactoring.
      def searcher.supplier=(value) @supplier = value; end
      searcher.supplier = supplier
      def searcher.search
         (super || {}).merge belongs_to_supplier: @supplier
      end
      searcher.retrieve_products
    end
    
    def permit_params
      params.require(:supplier).permit :name, :email
    end
    
    def load_model
      @supplier = Spree::Supplier::find_by(slug: params[:id])
    end
  end
end
