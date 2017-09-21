# rubocop:disable Metrics/BlockLength
ActiveAdmin.register UserExtra do
  CERT_STATUS = UserExtra.statuses.keys
  CERT_TYPE = %w(chinese_id passport_id).collect { |d| [I18n.t("cert_type.#{d}"), d] }
  belongs_to :user, optional: true
  actions :all, except: [:show]
  menu false

  permit_params :user_id, :real_name, :cert_type, :cert_no, :memo, :image, :status

  scope :all
  scope('chinese_id') { |scope| scope.where(cert_type: 'chinese_id') }
  scope('passport_id') { |scope| scope.where(cert_type: 'passport_id') }

  batch_action :'审核通过', confirm: '确定操作吗?' do |ids|
    UserExtra.find(ids).each do |user_extra|
      user_extra.update(memo: '实名已通过', status: 'passed')
    end
    redirect_back fallback_location: admin_user_extras_url, notice: '批量审核成功！'
  end

  batch_action :destroy, false

  filter :user_user_uuid, as: :string
  filter :user_nick_name, as: :string
  filter :real_name
  filter :cert_no
  filter :status, as: :select, collection: CERT_STATUS.collect { |key| [I18n.t("user_extra.#{key}"), key] }

  index do
    selectable_column
    id_column
    column :user_id do |user_extra|
      if user_extra.try(:user).present?
        link_to user_extra.user.nick_name, admin_user_url(user_extra.user), target: '_blank'
      end
    end
    column :real_name
    column :cert_type, sortable: false do |user_extra|
      I18n.t("cert_type.#{user_extra.cert_type}")
    end
    column :cert_no
    column :image do |user_extra|
      user_extra.image.url ? link_to(image_tag(user_extra.image.url, height: 100), user_extra.image.url, target: '_blank') : ''
    end
    column :status, sortable: false do |user_extra|
      I18n.t("user_extra.#{user_extra.status}")
    end
    column :default
    column :created_at
    column :memo
    actions name: '审核操作', defaults: false do |user_extra|
      item '通过', success_certify_admin_user_extra_path(user_extra),
           data: { confirm: '确定通过审核吗？' }, method: :post, class: 'member_link'
      item '拒绝', fail_certify_admin_user_extra_path(user_extra), remote: true
    end
    actions name: '更多操作'
  end

  member_action :success_certify, method: :post do
    Services::SysLog.call(current_admin_user, resource, '实名审核',
                          "通过：#{resource.real_name}的审核请求")
    resource.update(memo: '实名已通过', status: 'passed')
    redirect_back fallback_location: admin_user_extras_url, notice: '审核操作成功'
  end

  member_action :fail_certify, method: [:get, :post] do
    @user_extra = resource
    if request.post?
      memo = params[:memo]
      @user_extra.update(memo: memo, status: 'failed')
      Services::SysLog.call(current_admin_user, resource, '实名审核',
                            "拒绝：#{resource.real_name}的审核请求")
      redirect_back fallback_location: admin_user_extras_url, notice: '审核操作成功'
    else
      render :fail_certify
    end
  end

  member_action :user_table, method: :get do
    render 'user_table'
  end

  action_item :users, only: :index do
    link_to '会员管理', admin_users_path
  end

  form partial: 'edit_user_extra'

  controller do
    def destroy
      resource.update(is_delete: 1)
      Services::SysLog.call(current_admin_user, resource, '实名审核',
                            "删除：#{resource.real_name}的审核请求")
      redirect_back fallback_location: admin_user_extras_url, notice: '删除成功！'
    end
  end
end
