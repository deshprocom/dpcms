# rubocop:disable Metrics/BlockLength
ActiveAdmin.register User do
  menu label: '会员管理', priority: 1
  permit_params :nick_name, :password, :password_confirmation, :email, :mobile, :mark, user_extra_attributes: [:real_name]
  CERTIFY_STATUS = UserExtra.statuses.keys
  CERT_TYPE = { passport_id: '护照', chinese_id: '身份证' }
  USER_STATUS = User.statuses.keys
  actions :all, except: [:new]

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

  filter :user_uuid
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
    success_count = UserExtra.where(status: 'success').count
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
    def update
      update! do |format|
        format.html { redirect_to admin_users_url }
      end
    end
  end

  # 用户认证审核通过
  member_action :user_audit, method: :post do
    user_extra = resource.user_extra
    return render 'user_audit_failed' if user_extra.blank?
    Services::SysLog.call(current_admin_user, resource, 'user_audit',
                          "通过了用户#{resource.user_extra.real_name}的审核认证")
    user_extra.passed!
  end

  # 用户审核不通过
  member_action :user_audit_forbid, method: :post do
    memo = params[:memo] || user_extra.memo
    user_extra = resource.user_extra
    return render 'user_audit_failed' if user_extra.blank?
    Services::SysLog.call(current_admin_user, resource, 'user_audit',
                          "拒绝了用户#{resource.user_extra.real_name}的审核认证")
    user_extra.update!(memo: memo, status: 'failed')
  end

  # 禁用用户和启用用户
  member_action :user_banned, method: :post do
    resource.role.eql?('banned') ? resource.update!(role: 'basic') : resource.update!(role: 'banned')
    notice_str = resource.role.eql?('banned') ? '取消禁用' : '禁用'
    Services::SysLog.call(current_admin_user, resource, notice_str, "#{notice_str}用户: #{resource.id} - #{resource.nick_name}")
    redirect_back fallback_location: admin_users_url, notice: "#{notice_str}用户：#{resource.nick_name}成功！"
  end
end