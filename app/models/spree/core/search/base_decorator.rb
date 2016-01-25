##
# Adds filter to frontend searcher.
# scope 'belongs_active_supplier' returns only products belong active supplier.
Spree::Core::Search::Base.class_eval do
  def search
    [:belongs_active_supplier]
  end
end