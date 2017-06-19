module Services
  class SysLog
    include Serviceable
    attr_accessor :admin_user, :operation, :action, :mark

    def initialize(admin_user, operation, action, mark = '')
      self.admin_user = admin_user
      self.action = action
      self.mark = mark
      self.operation = operation
    end

    def call
      AdminSysLog.create!(admin_user: admin_user,
                          operation: operation,
                          action: action,
                          mark: mark)
    end
  end
end

