Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_product',
  name: 'hide_prototypes_submenu_form_admin_for_supplier_2',
  replace: 'erb:contains("tab :prototypes")',
  text: '<%= tab :prototypes if can?(:admin, Spree::Prototype) && (can?(:update, Spree::Prototype) || can?(:create, Spree::Prototype)) %>'
)
