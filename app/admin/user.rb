ActiveAdmin.register User do
  menu false

  # 用户认证审核通过
  member_action :user_audit, method: :post do
    user_extra = resource.user_extra
    return render 'user_audit_failed' if user_extra.blank?
    user_extra.passed!
  end

  # 用户审核不通过
  member_action :user_audit_forbid, method: :post do
    memo = params[:memo] || user_extra.memo
    user_extra = resource.user_extra
    return render 'user_audit_failed' if user_extra.blank?
    user_extra.update!({ memo: memo, status: 'failed' })
  end
end