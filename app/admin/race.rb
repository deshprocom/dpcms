ActiveAdmin.register Race do
  menu label: '赛事列表', priority: 1
  permit_params :name, :logo, :prize, :location, :begin_date, :end_date, :status,
                ticket_info_attributes: [:e_ticket_number, :entity_ticket_number],
                race_desc_attributes: [:description]
  RACE_STATUS = Race.statuses.keys
  config.per_page = 20

  filter :name
  filter :location
  filter :begin_date
  filter :status, as: :select, collection: RACE_STATUS.collect {|d| [I18n.t(d), d]}

  index do
    column :logo, sortable: false do |race|
      link_to race.logo.url ? image_tag(race.logo.url(:preview)) : '', admin_race_path(race)
    end
    column :name, sortable: false  do |race|
      link_to race.name, admin_race_path(race)
    end
    column :prize
    column '赛事时间', sortable: :begin_date do |race|
      "#{race.begin_date} 至 #{race.end_date}"
    end
    column :location, sortable: false
    column :status, sortable: false do |race|
      select_tag :status, options_for_select(RACE_STATUS.collect {|d| [I18n.t(d), d]}, race.status),
                 data: { before_val: race.status, id: race.id }, class: 'test'
    end
    actions
  end

  show  do
    attributes_table do
      row :name
      row(:prize) { "#{race.prize} 元" }
      row :location
      row(:status) { I18n.t(race.status) }
      row('赛事时间') { "#{race.begin_date} 至 #{race.end_date}" }
      row :logo do |race|
        link_to image_tag(race.logo.url :preview), race.logo.url, target: '_blank'
      end
      attributes_table_for race.race_desc do
        row :description
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

  member_action :change_status, method: :put do
    unless params[:status].in? RACE_STATUS
      return render json: { error: 'ParamsError' }, status: 404
    end

    resource.send("#{params[:status]}!")
    render json: resource
  end
end
