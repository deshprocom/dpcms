# rubocop:disable Metrics/BlockLength
ActiveAdmin.register ProductImage, as: 'images' do
  config.batch_actions = false
  config.filters = false
  config.paginate = false

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
      @image = @product.images.build(permitted_params[:product_image])
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

end
