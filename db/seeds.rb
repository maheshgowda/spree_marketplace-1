require 'highline/import'

create_supplier = ask('Create new supplier and set him supplier of products without supplier [Y/n]? ') do |q|
  q.default = 'y'
  q.validate = /^([yY]|[nN])$/
end
return if create_supplier.downcase != 'y'

user_login = ask('Supplier user login [spree@example.com]: ') { |q| q.default = 'spree@example.com' }
new_supplier_name = ask('Supplier name [Spree]: ') { |q| q.default = 'Spree' }

user = User.find_by(login: user_login)
unless user
  say("User #{user_login} isn't exists, supplier isn't created.")
  return
end
if user.supplier_id
  say("User #{user_login} already supplier.")
  return
end
supplier = Supplier.create(name: new_supplier_name, active: true)
user.update(supplier_id: supplier.id)
Product.where(supplier_id: nil).update!(supplier_id: supplier.id)

say("Supplier successfully created")