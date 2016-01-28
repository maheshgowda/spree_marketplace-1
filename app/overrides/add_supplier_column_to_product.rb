Deface::Override.new(virtual_path: 'spree/products/show',
  name: 'change_center_column_of_product',
  set_attributes: 'div[data-hook="product_right_part"]',
  attributes: { class: 'col-md-6' }
)

Deface::Override.new(virtual_path: 'spree/products/show',
  name: 'add_supplier_column_to_product',
  insert_after: 'div[data-hook="product_right_part"]',
  text:
    '<div class="col-md-2 text-center">
      <a href="<%= supplier_path(@product.supplier.slug) %>">
        <div class="product-supplier-avatar"><%= image_tag @product.supplier.avatar %></div>
      </a>
      <a href="<%= supplier_path(@product.supplier.slug) %>">
        <div class="product-supplier-name"><%= @product.supplier.name %></div>
      </a>
    </div>'
)
