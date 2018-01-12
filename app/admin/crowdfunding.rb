ActiveAdmin.register Crowdfunding do
  permit_params :race_id, :master_image, :cf_cond, :expire_time,
                :publish_time, :award_time, crowdfunding_categories_attributes: [:id, :description, :name, :_destroy]

  form partial: 'form'

  index do
    render 'index', context: self
  end

  collection_action :race_table, method: :get

  collection_action :search_race, method: :get do
    keyword = params[:content].to_s
    like_sql = 'name like ? or location like ?'
    @races = Race.where(like_sql, "%#{keyword}%", "%#{keyword}%").order(id: :desc).page(params[:page]).per(8)
  end

  collection_action :search_sub_races, method: :get do
    @races = Race.find(params[:id]).sub_races.order(id: :desc).page(params[:page]).per(8)
    render 'search_race'
  end

  member_action :add_category, method: [:get, :post] do
    return render 'add_category' unless request.post?
    resource.crowdfunding_categories.create(name: params[:name])
    render 'common/update_success'
  end

  member_action :publish, method: :post do
    resource.publish!
    redirect_back fallback_location: admin_crowdfundings_url, notice: '发布成功'
  end

  member_action :unpublish, method: :post do
    resource.unpublish!
    redirect_back fallback_location: admin_crowdfundings_url, notice: '取消发布成功'
  end

  controller do
    def new
      @crowdfunding = Crowdfunding.new
    end
  end
end
