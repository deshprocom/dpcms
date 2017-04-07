ActiveAdmin.register Race, as: 'sub_races' do
  config.filters = false
  config.batch_actions = false

  belongs_to :race
  navigation_menu :default
  menu false

  index title: proc { @race.name } do
    render 'index', context: self
  end

  permit_params :name, :logo, :prize, :location, :begin_date, :end_date, :status, :roy,
                :ticket_price, :ticket_sellable, :describable, :parent_id, :blind, :participants,
                ticket_info_attributes: [:e_ticket_number, :entity_ticket_number],
                race_desc_attributes: [:description, :schedule]
  form do |f|
    render 'form', f: f
  end
end
