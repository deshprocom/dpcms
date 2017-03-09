module Admin
  module PurchaseOrderHelper

    extend ActiveSupport::Concern

    def self.order_status
      {
          unpaid: I18n.t('activerecord.filters.unpaid'),
          paid: I18n.t('activerecord.filters.paid'),
          completed: I18n.t('activerecord.filters.completed'),
          canceled: I18n.t('activerecord.filters.canceled')
      }
    end

    def self.order_status_collection
      [ [I18n.t('activerecord.filters.unpaid'), 'unpaid'],
        [I18n.t('activerecord.filters.paid'), 'paid'],
        [I18n.t('activerecord.filters.completed'), 'completed'],
        [I18n.t('activerecord.filters.canceled'), 'canceled'] ]
    end
  end
end
