module ShopHelper
  def roots_collection
    Category.roots.collect { |c| [ c.name, c.id ] }
  end
end
