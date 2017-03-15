# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Race do
  controller.include RaceHelper
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
    render 'index', context: self
  end

  show do
    render 'show', context: self
  end

  form partial: 'form'

  before_action :unpublished?, only: [:destroy]
  controller do
    def unpublished?
      @race = Race.find(params[:id])
      return unless @race.published?

      flash[:error] = I18n.t('race.destroy_error')
      redirect_back fallback_location: admin_races_url
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
    redirect_back fallback_location: admin_races_url, notice: I18n.t('race.publish_notice')
  end

  member_action :unpublish, method: :post do
    Race.find(params[:id]).unpublish!
    redirect_back fallback_location: admin_races_url, notice: I18n.t('race.unpublish_notice')
  end


  action_item :publish, only: :show do
    publish_status_link(race)
  end
end
