Spree::Api::ProductsController.class_eval do

=begin
  respond_override create: { json: { success: lambda {
    @product.add_supplier!(spree_current_user.supplier) if spree_current_user.supplier
  } } }
=end

def create
  authorize! :create, Spree::Product
  raise 'Fuck you!!!'
  params[:product][:available_on] ||= Time.now
  set_up_shipping_category

  options = {
    variants_attrs: variants_params,
    options_attrs: option_types_params
  }
  @product =
    Spree::Core::Importer::Product.new(nil, product_params, options).create

  if @product.persisted?
    @product.add_supplier!(spree_current_user.supplier) if spree_current_user.supplier
    respond_with(@product, :status => 201, :default_template => :show)
  else
    invalid_resource! @product
  end
end


end
