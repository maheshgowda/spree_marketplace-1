##
# Adds filter to frontend searcher.
# scope 'belongs_active_supplier' returns only products belong active supplier.
Spree::Core::Search::Base.class_eval do
  alias_method :origin_search, :search if defined?(search)
  def search
    ret = origin_search if defined?(origin_search)
    ret = {} unless ret
    ret[:belongs_active_supplier] = nil
    ret
  end
end