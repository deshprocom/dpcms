# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Product do
  config.batch_actions = false

  permit_params :title, :icon, :description, :type, :category_id,
                master_attributes: [:original_price, :price, :stock,
                                    :volume, :origin_point, :weight]

  form partial: 'form'
  sidebar '侧边栏', only: [:edit, :update, :variants] do
    product_sidebar_generator(self)
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
end
