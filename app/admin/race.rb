ActiveAdmin.register Race do
  menu label: '赛事列表', priority: 1
  permit_params :name, :logo, :prize, :location, :begin_date, :end_date, :status
  config.filters = false
  scope :all, default: true

  RACE_STATUS_MAPPING = %w(未开始 进行中 已结束 已关闭)
  index do
    selectable_column
    # column :logo do |race|
    #   link_to image_tag(race.logo), admin_race_path(race)
    # end
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


  sidebar '赛事详情', only: [:show, :edit] do
    ul do
      li link_to '该赛事的票', admin_race_tickets_path(resource)
    end
  end

  form partial: 'form'

  #
  # form do |f|
  #   f.inputs '赛事简介' do
  #     f.input :name
  #     f.input :prize
  #     f.input :location
  #     f.input :begin_date
  #     f.input :end_date
  #     f.input :logo, as: :file
  #     f.input :status , as: :select, collection: [%w(未开始 0), %w(进行中 1), %w(已结束 2), %w(已关闭 3)]
  #   end
  #
  #   f.inputs '门票数量信息', for: :ticket_info do |ticket|
  #       ticket.input :e_ticket_number, as: :number
  #       ticket.input :entity_ticket_number, as: :number
  #       ticket.input :e_ticket_sold_number, as: :number
  #       ticket.input :entity_ticket_sold_number, as: :number
  #   end
  #   f.actions
  # end

end
