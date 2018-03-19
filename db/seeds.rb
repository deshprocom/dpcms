# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless AdminUser.exists?(email: 'admin@deshpro.com')
  AdminUser.create!(email: 'admin@deshpro.com', password: 'password', password_confirmation: 'password')
end

unless AdminRole.exists?(name: '超级管理员')
  role = AdminRole.create!(name: '超级管理员', permissions: CmsAuthorization.permissions)
  admin = AdminUser.find_by(email: 'admin@deshpro.com')
  admin.admin_roles = [ role ]
  admin.save
end