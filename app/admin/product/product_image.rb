# rubocop:disable Metrics/BlockLength
ActiveAdmin.register ProductImage, as: 'images' do
  config.batch_actions = false
  config.filters = false
  config.paginate = false
  config.sort_order = 'position_asc'

  config.clear_action_items!
  action_item :add, only: :index do
    link_to '新增图片', new_admin_product_image_path(product), remote: true
  end

  belongs_to :product
  navigation_menu :default
  menu false

  sidebar '侧边栏' do
    product_sidebar_generator(self)
  end

  permit_params :filename

  index title: '图片管理', download_links: false do
    render 'admin/products/images/index', context: self
  end

  form partial: 'admin/products/images/form'

  controller do
    before_action :set_product, only: [:new, :create, :edit, :update]
    before_action :set_image, only: [:edit, :update]

    def new
      @image = @product.images.build
      render 'admin/products/images/new'
    end

    def create
      last_img = @product.images.position_asc.last
      position = last_img&.position.to_i + 100000
      @image = @product.images.build(permitted_params[:product_image].merge(position: position))
      flash[:notice] = '新建成功' if @image.save
      render 'admin/products/images/response'
    end

    def edit
      render 'admin/products/images/new'
    end

    def update
      @image.assign_attributes(permitted_params[:product_image])
      flash[:notice] = '更新成功' if @image.save
      render 'admin/products/images/response'
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_image
      @image = @product.images.find(params[:id])
    end
  end

  member_action :reposition, method: :post do
    image = ProductImage.find(params[:id])
    next_img = params[:next_id] && ProductImage.find(params[:next_id].split('_').last)
    prev_img = params[:prev_id] && ProductImage.find(params[:prev_id].split('_').last)
    position = if params[:prev_id].blank?
                 next_img.position / 2
               elsif params[:next_id].blank?
                 prev_img.position + 100000
               else
                 (prev_img.position + next_img.position) / 2
               end
    image.update(position: position)
  end
end
