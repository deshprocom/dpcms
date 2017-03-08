module Admin
  module PurchaseOrderHelper

    extend ActiveSupport::Concern

    def self.order_status_collection
      PurchaseOrder.statuses.keys.collect { |key| [I18n.t(key), key] }
    end
  end
end
