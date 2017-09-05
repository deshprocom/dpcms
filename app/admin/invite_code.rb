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

  form partial: 'form'
end
