ActiveAdmin.register User do
  menu false

  # 用户认证审核通过
  member_action :user_audit, method: :post do
    user_extra = resource.user_extra
    if user_extra.blank?
      return render 'user_audit_failed'
    end
    user_extra.passed!
  end

  # 用户审核不通过
  member_action :user_audit_forbid, method: :post do
    user_extra = resource.user_extra
    if user_extra.blank?
      return render 'user_audit_failed'
    end
    user_extra.failed!
  end
end