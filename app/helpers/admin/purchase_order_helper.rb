module Admin
  module PurchaseOrderHelper
    def self.order_status
      {
        unpaid: I18n.t('activerecord.filters.unpaid'),
        paid: I18n.t('activerecord.filters.paid'),
        completed: I18n.t('activerecord.filters.completed'),
        canceled: I18n.t('activerecord.filters.canceled')
      }
    end

    def self.t_order_status
      [ [I18n.t('activerecord.filters.unpaid'), 'unpaid'],
        [I18n.t('activerecord.filters.paid'), 'paid'],
        [I18n.t('activerecord.filters.completed'), 'completed'],
        [I18n.t('activerecord.filters.canceled'), 'canceled'] ]
    end
  end
end
