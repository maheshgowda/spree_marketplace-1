require 'highline/import'

def spree_marketplace_create_supplier
  user_login = ask('Supplier user login: ') { |q| q.default = 'spree@example.com' }
  new_supplier_name = ask('Supplier name: ') { |q| q.default = 'Spree' }
  user = Spree::User.find_by(login: user_login)
  unless user
    puts "User #{user_login} isn't exists, supplier isn't created. No supplier created."
    return
  end
  if user.supplier_id
    puts "User #{user_login} already supplier. No supplier created."
    return
  end
  supplier = Spree::Supplier.create!(name: new_supplier_name, active: true, email: user.email)
  user.update supplier_id: supplier.id
  Spree::Product.where(supplier_id: nil).update_all supplier_id: supplier.id
  puts 'Supplier successfully created.'
end

if ask('Create new supplier and set him supplier of products without supplier? [Y/n]') { |q| q.default = 'y' }.downcase == 'y'
  spree_marketplace_create_supplier
else
  puts 'No supplier created.'
end

