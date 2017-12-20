# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Comment do
  menu priority: 24
  config.breadcrumb = false

  filter :user_nick_name_or_replies_user_nick_name, as: :string
  filter :topic_type
  filter :body_or_replies_body, as: :string
  filter :recommended
  filter :created_at_replies_created_at, as: :date_range

  index download_links: false do
    render 'index'
  end

  member_action :add_recommend, method: :post do
    resource.recommend!
    redirect_back fallback_location: admin_comments_url, notice: '加入精选成功'
  end

  member_action :delete_recommend, method: :post do
    resource.unrecommend!
    redirect_back fallback_location: admin_comments_url, notice: '移除精选成功'
  end

  member_action :delete_comment, method: [:get, :post] do
    return render :delete unless request.post?
    resource.admin_delete(params[:reason])
    redirect_back fallback_location: admin_comments_url, notice: '删除成功'
  end

  controller do
    def apply_filtering(chain)
      super(chain).distinct
    end
  end
end
