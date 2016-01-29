Spree::Supplier.class_eval do
  
  scope :active, ->() { where active: true }

  def supplier_variants
    raise NoMethodError
  end
  
  has_many :products
  has_many :variants, through: :products

  has_attached_file :background,
    styles: { large: '1200x300#' },
    default_style: :large,
    url: '/spree/suppliers/background/:id/:style/:basename.:extension',
    path: ':rails_root/public/spree/suppliers/background/:id/:style/:basename.:extension',
    default_url: 'default_supplier_background.jpg'
  has_attached_file :avatar,
    styles: { small: '150x150#', product:'240x240#', large: '800x600>' },
    default_style: :product,
    url: '/spree/suppliers/avatar/:id/:style/:basename.:extension',
    path: ':rails_root/public/spree/suppliers/avatar/:id/:style/:basename.:extension',
    default_url: 'noimage/product.png'

  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }
  validates_attachment :background, content_type: { content_type: /\Aimage\/.*\Z/ }
  
end
