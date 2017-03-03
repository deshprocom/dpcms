ActiveAdmin.register Race do
  menu label: '赛事列表', priority: 1
  permit_params :name, :logo, :prize, :location, :begin_date, :end_date, :status,
                ticket_info_attributes: [:e_ticket_number, :entity_ticket_number],
                race_desc_attributes: [:description]
  config.filters = false
  scope :all, default: true

  RACE_STATUS_MAPPING = %w(未开始 进行中 已结束 已关闭)

  index do
    column :logo do |race|
      link_to race.logo.url ? image_tag(race.logo.url(:preview)) : '', admin_race_path(race)
    end
    column :name do |race|
      link_to race.name, admin_race_path(race)
    end
    column :prize
    column '赛事时间' do |race|
      "#{race.begin_date} 至 #{race.end_date}"
    end
    column :location
    column '赛事状态' do |race|
      RACE_STATUS_MAPPING[race.status]
    end
    actions name: '操作'
  end

  show  do
    attributes_table do
      row :name
      row(:prize) { "#{race.prize} 元" }
      row :location
      row(:status) { RACE_STATUS_MAPPING[race.status] }
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
end
