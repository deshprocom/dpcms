ActiveAdmin.register User do
  menu false

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
end