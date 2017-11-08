# rubocop:disable Metrics/BlockLength
PRODUCT_TYPES = Product.product_types.keys
TRANS_PRODUCT_TYPES = PRODUCT_TYPES.collect { |d| [I18n.t("product.#{d}"), d] }
ActiveAdmin.register Product do
  config.batch_actions = false
  config.sort_order = 'published_desc'

  permit_params :title, :icon, :description, :product_type, :category_id, :published,
                master_attributes: [:original_price, :price, :stock,
                                    :volume, :origin_point, :weight]

  sidebar '侧边栏', only: [:edit, :update, :variants] do
    product_sidebar_generator(self)
  end

  form partial: 'form'

  index do
    render 'index', context: self
  end

  controller do
    def create
      @product = Product.new(permitted_params[:product])
      if @product.save
        flash[:notice] = '新建商品详情成功'
        redirect_to edit_admin_product_path(@product)
      else
        render :new
      end
    end

    def update
      @product = Product.find(params[:id])
      if @product.update(permitted_params[:product])
        flash[:notice] = '修改商品详情成功'
        redirect_to edit_admin_product_path(@product)
      else
        flash[:error] = '修改商品详情失败'
        render :edit
      end
    end
  end

  member_action :publish, method: :post do
    Product.find(params[:id]).publish!
    redirect_back fallback_location: admin_products_url, notice: '上架商品成功'
  end

  member_action :unpublish, method: :post do
    Product.find(params[:id]).unpublish!
    redirect_back fallback_location: admin_products_url, notice: '下架商品成功'
  end
end
