# rubocop:disable Metrics/BlockLength
ActiveAdmin.register User do
  menu priority: 1, parent: '用户管理', label: 'app用户'

  permit_params :nick_name, :password, :password_confirmation, :email, :mobile, :mark, user_extra_attributes: [:id, :status]
  CERTIFY_STATUS = UserExtra.statuses.keys
  USER_STATUS = User.statuses.keys
  actions :all, except: [:new, :destroy]

  scope :all
  scope('race_order_succeed') do |scope|
    scope.joins(:orders).where('purchase_orders.status NOT IN (?)', %w(unpaid canceled)).distinct
  end

  batch_action :'批量禁用', confirm: '确定操作吗?' do |ids|
    User.find(ids).each do |user|
      user.update(role: 'banned') unless user.role.eql?('banned')
    end
    Services::SysLog.call(current_admin_user, User.find(ids.first), 'batch_banned', "被禁用的id为->: #{ids.join(', ')}")
    redirect_back fallback_location: admin_users_url, notice: '批量禁用操作成功！'
  end

  batch_action :'批量启用', confirm: '确定操作吗?' do |ids|
    User.find(ids).each do |user|
      user.update(role: 'basic') if user.role.eql?('banned')
    end
    Services::SysLog.call(current_admin_user, User.find(ids.first), 'batch_unbanned', "被启用的id为->: #{ids.join(', ')}")
    redirect_back fallback_location: admin_users_url, notice: '批量启用操作成功！'
  end

  batch_action :destroy, false

  filter :id
  filter :user_name
  filter :nick_name
  filter :email
  filter :mobile
  filter :reg_date
  filter :last_visit
  filter :role, as: :select, collection: USER_STATUS.collect { |key| [I18n.t("user.#{key}"), key] }
  filter :user_extra_status, as: :select, collection: CERTIFY_STATUS.collect { |key| [I18n.t("user_extra.#{key}"), key] }

  index do
    render 'index', context: self
  end

  show do
    render 'show', context: self
  end

  form partial: 'form'

  sidebar :'数量统计', only: :index do
    success_count = UserExtra.where(status: 'passed').count
    bind_count = User.where.not(mobile: nil).count
    ul do
      li "会员数量：#{User.count}名"
      li "已实名数量：#{success_count}名"
      li "未实名数量：#{User.count - success_count}名"
      li "已绑手机用户：#{bind_count}名"
      li "未绑手机用户：#{User.count - bind_count}名"
    end
  end

  controller do
    before_action :init_params, only: [:update]

    def update
      Services::SysLog.call(current_admin_user, resource, '编辑用户', "被修改的用户id为->: #{resource.id}")
      update! do |format|
        format.html { redirect_to admin_users_url + "#user_#{resource.id}" }
      end
    end

    private

    def init_params
      params[:user][:mobile] = nil if params[:user][:mobile].blank?
      params[:user][:email] = nil if params[:user][:email].blank?
    end
  end

  # 禁用用户和启用用户
  member_action :user_banned, method: :post do
    resource.role.eql?('banned') ? resource.update!(role: 'basic') : resource.update!(role: 'banned')
    notice_str = resource.role.eql?('banned') ? '禁用' : '取消禁用'
    Services::SysLog.call(current_admin_user, resource, notice_str, "#{notice_str}用户: #{resource.id} - #{resource.nick_name}")
    redirect_back fallback_location: admin_users_url, notice: "#{notice_str}用户：#{resource.nick_name}成功！"
  end

  action_item :user_extras, only: :index do
    link_to '实名列表', admin_user_extras_path
  end
end