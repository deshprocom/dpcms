# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Race do
  config.batch_actions = false
  menu label: I18n.t('race.manage'), priority: 1
  permit_params :name, :logo, :prize, :location, :begin_date, :end_date, :status,
                :ticket_price, :ticket_sellable, :describable,
                ticket_info_attributes: [:e_ticket_number, :entity_ticket_number],
                race_desc_attributes: [:description]
  RACE_STATUSES = Race.statuses.keys
  TRANS_RACE_STATUSES = RACE_STATUSES.collect { |d| [I18n.t("race.#{d}"), d] }
  TICKET_STATUSES = Race.ticket_statuses.keys
  TRANS_TICKET_STATUSES = TICKET_STATUSES.collect { |d| [I18n.t("race.ticket_status.#{d}"), d] }

  filter :name
  filter :location
  filter :begin_date
  filter :status, as: :select, collection: TRANS_RACE_STATUSES, if: :in_race_list?
  filter :ticket_status, as: :select, collection: TRANS_TICKET_STATUSES, if: :in_ticket_manage?

  index title: I18n.t('race.list'), as: RacesIndex do
    render 'index', context: self
  end

  index title: I18n.t('race.ticket_manage'), as: TicketManageIndex do
    render 'ticket_manage_index', context: self
  end

  show do
    render 'show', context: self
  end

  form partial: 'form'

  controller do
    include RaceHelper
    before_action :unpublished?, only: [:destroy]

    def unpublished?
      @race = Race.find(params[:id])
      return unless @race.published?

      flash[:error] = I18n.t('race.destroy_error')
      redirect_back fallback_location: admin_races_url
    end

    def scoped_collection
      return super.ticket_sellable if in_ticket_manage?

      super
    end
  end

  member_action :change_status, method: :put do
    resource.send("#{params[:status]}!")
    render json: resource
  end

  member_action :publish, method: :post do
    race = Race.find(params[:id])
    race.publish!
    redirect_back fallback_location: admin_races_url, notice: I18n.t('race.publish_notice')
  end

  member_action :unpublish, method: :post do
    Race.find(params[:id]).unpublish!
    redirect_back fallback_location: admin_races_url, notice: I18n.t('race.unpublish_notice')
  end

  member_action :cancel_sell, method: :post do
    race = Race.find(params[:id])
    unless race.ticket_status == 'unsold'
      flash[:error] = I18n.t('race.cancel_sell_error')
      return redirect_back fallback_location: admin_races_url
    end
    race.cancel_sell!
    redirect_back fallback_location: admin_races_url, notice: I18n.t('race.cancel_sell_notice')
  end

  action_item :publish, only: :show do
    publish_status_link(race)
  end
end
