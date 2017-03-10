# 用户相关的验证器
class UserValidator
  include EmailValidator
  include MobileValidator
end
