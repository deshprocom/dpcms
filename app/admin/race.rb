# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Race do
  self.controller.include RaceHelper
  menu label: '赛事列表', priority: 1
  permit_params :name, :logo, :prize, :location, :begin_date, :end_date, :status,
                ticket_info_attributes: [:e_ticket_number, :entity_ticket_number],
                race_desc_attributes: [:description]
  RACE_STATUSES = Race.statuses.keys

  filter :name
  filter :location
  filter :begin_date
  filter :status, as: :select, collection: RACE_STATUSES.collect { |d| [I18n.t("race.#{d}"), d] }

  index do
    column(:logo, sortable: false) { |race| logo_link_to_show(race) }
    column(:name, sortable: false) { |race| link_to race.name, admin_race_path(race)}
    column(:prize) { |race| format_prize(race) }
    column(I18n.t('race.period'), sortable: :begin_date) { |race| race_period(race) }
    column(:location, sortable: false)
    column(:status, sortable: false) { |race| select_to_status(race) }
    column(:published, sortable: false) { |race| publish_status_link(race) }
    actions(defaults: false) { |race| index_table_actions(self, race) }
  end

  show do
    attributes_table do
      row :name
      row(:prize) { format_prize(race) }
      row :location
      row(:status) { I18n.t("race.#{race.status}") }
      row(I18n.t('race.period')) { race_period(race) }
      row(:logo){ show_big_logo_link(race) }
      attributes_table_for race.race_desc do
        row(:description) { markdown(race.race_desc.description) }
      end
    end

    panel '门票信息' do
      attributes_table_for race.ticket_info do
        row :e_ticket_number
        row :entity_ticket_number
        row :e_ticket_sold_number
        row :entity_ticket_sold_number
      end
    end
  end

  form partial: 'form'

  before_action :unpublished?, only: [:destroy]
  controller do
    def unpublished?
      @race = Race.find(params[:id])
      if @race.published?
        flash[:error] = I18n.t('race.destroy_error')
        redirect_to :back
      end
    end
  end

  member_action :change_status, method: :put do
    unless params[:status].in? RACE_STATUSES
      return render json: { error: 'ParamsError' }, status: 404
    end
    resource.send("#{params[:status]}!")
    render json: resource
  end

  member_action :publish, method: :post do
    Race.find(params[:id]).publish!
    redirect_to :back, notice: I18n.t('race.publish_notice')
  end

  member_action :unpublish, method: :post do
    Race.find(params[:id]).unpublish!
    redirect_to :back, notice: I18n.t('race.unpublish_notice')
  end

  action_item :publish, only: :show do
    publish_status_link(race)
  end
end
