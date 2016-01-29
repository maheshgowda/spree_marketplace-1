Spree::OptionType.class_eval do
  has_many :suppliers, through: :products
end