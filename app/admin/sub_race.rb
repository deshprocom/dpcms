# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Race, as: 'SubRace' do
  config.filters = false
  config.batch_actions = false

  belongs_to :race
  navigation_menu :default
  menu false

  index title: proc { @race.name } do
    render 'index', context: self
  end

  show do
    render 'show', context: self
  end

  controller do
    before_action :unpublished?, only: [:destroy]

    def unpublished?
      @sub_race = Race.find(params[:id])
      return unless @sub_race.published?

      flash[:error] = I18n.t('race.destroy_error')
      redirect_back fallback_location: admin_races_url
    end
  end

  permit_params :name, :logo, :prize, :location, :begin_date, :end_date, :status, :roy,
                :ticket_price, :ticket_sellable, :describable, :parent_id, :blind, :participants,
                # ticket_info_attributes: [:e_ticket_number, :entity_ticket_number],
                race_desc_attributes: [:description, :schedule]
  form do |f|
    render 'form', f: f
  end

  action_item :publish, only: :show do
    publish_status_link(race)
  end
end
