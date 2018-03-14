class CmsAuthorization < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    ActiveAdmin.application.namespace(:shop).resources.keys
    case subject
      when ActiveAdmin::Page # Dashboard
        true
      when Class # 所有的models
        can? subject.model_name.element
      when ActiveAdmin::Resource
        can? subject.resource_name.element
      else
        can? resource.resource_name.element
    end
  end

  def can?(name)
    name.in? user.permissions
  end

  def self.admin_permissions
    @admin_permissions ||= Dir["#{Rails.root.join('app/admin')}/*.rb"].map do |file|
      File.basename(file).chomp('.rb')
    end
  end

  def self.shop_permissions
    @shop_permissions ||= Dir["#{Rails.root.join('app/shop')}/**/*.rb"].map do |file|
      File.basename(file).chomp('.rb')
    end
  end

  def self.permissions
    @permissions ||= admin_permissions + shop_permissions
  end

  def self.permissions_with_trans
    @permissions_with_trans ||= permissions.map do |permission|
      [I18n.t("activerecord.models.#{permission}"), permission]
    end
  end
end