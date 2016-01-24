Deface::Override.new(virtual_path: 'spree/users/show',
  name: 'add_supplier_link_to_user_show',
  insert_after: '.account-summary.well',
  text: '<div data-hook="account_my_shop" class="account-my-shop">
    <h3><%= Spree.t(:my_shop) %></h3>
    <div>
      <% if spree_current_user.supplier %>
        <%= spree_current_user.supplier.name %>
        (<%= link_to Spree.t(:edit),
                     edit_admin_supplier_path(spree_current_user.supplier) %>)
      <% else %>
        <div class="alert alert-info">
          You do not have a shop yet.
          <%= link_to Spree.t(:create_shop), new_supplier_path %>
        </div>
      <% end %>
    </div>
  </div>'
)
