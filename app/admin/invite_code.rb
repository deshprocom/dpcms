# rubocop:disable Metrics/BlockLength
ActiveAdmin.register InviteCode do
  config.batch_actions = false

  permit_params :name, :mobile, :email

  index do
    render 'index', context: self
  end

  # 详情
  show do
    render 'show', context: self
  end

  # 删除
  controller do
    def destroy
      Services::SysLog.call(current_admin_user, resource, '邀请码',
                            "邀请码被删除：删除的信息 -> #{sms_log_field(resource)}")
      super
    end

    private

    def sms_log_field(data)
      return '' if data.blank?
      {
        id: data.id,
        name: data.name,
        mobile: data.mobile,
        email: data.email,
        code: data.code
      }
    end
  end

  form partial: 'form'
end
