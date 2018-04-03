# rubocop:disable Metrics/BlockLength
ActiveAdmin.register UserTopic do
  menu priority: 9, label: '社交管理'

  actions :index

  includes :counter, :user

  BODY_TYPE = { 'short' => '说说', 'long' => '长帖' }.freeze

  filter :title
  filter :body
  filter :user_id
  filter :body_type, as: :select, collection: BODY_TYPE.invert
  filter :location
  filter :published_time, as: :date_range

  scope 'square', :all
  scope 'essence', :recommended

  index do
    render 'index', context: self
  end

  member_action :recommend, method: :patch do
    UserTopic.update(params[:id], recommended: true)
    redirect_back fallback_location: admin_user_topics_url, notice: '加入精华成功'
  end

  member_action :unrecommend, method: :patch do
    UserTopic.update(params[:id], recommended: false)
    redirect_back fallback_location: admin_user_topics_url, notice: '加入精华成功'
  end

  member_action :delete, method: [:get, :post] do
    return(render 'delete') if request.get?
    resource.update(deleted: true, deleted_at: Time.current, deleted_reason: params[:deleted_reason])
    redirect_back fallback_location: admin_user_topics_url, notice: '删除成功'
  end
end
