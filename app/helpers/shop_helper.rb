module ShopHelper
  def roots_collection
    Category.roots.collect { |c| [c.name, c.id] }
  end

  def product_sidebar_generator(context)
    context.instance_eval do
      ul do
        li link_to '详情编辑', edit_admin_product_path(product)
        li '图片管理'
        li link_to '商品组合管理', admin_product_variants_path(product)
      end
    end
  end
end
