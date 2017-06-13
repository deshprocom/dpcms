# rubocop:disable Metrics/BlockLength
TICKET_CLASSES = Ticket.ticket_classes.keys
TRANS_TICKET_CLASSES = TICKET_CLASSES.collect { |d| [I18n.t("ticket.ticket_class.#{d}"), d] }
TICKET_STATUSES = Ticket.statuses.keys
TRANS_TICKET_STATUSES = TICKET_STATUSES.collect { |d| [I18n.t("ticket.status.#{d}"), d] }

ActiveAdmin.register Ticket do
  menu false
  belongs_to :race, optional: true
  belongs_to :sub_race, optional: true
  config.filters = false
  config.batch_actions = false
  breadcrumb do
    breadcrumb_links(ticket_breadcrumb_path)
  end

  permit_params :title, :description, :price, :original_price, :ticket_class, :status,
                ticket_info_attributes: [:e_ticket_number, :entity_ticket_number]

  form do |f|
    render 'form', f: f
  end

  index download_links: false do
    render 'index', context: self
  end

  show do
    render 'show', race: race, ticket: ticket, ticket_info: ticket.ticket_info
  end

  member_action :change_number, method: :post do
    result = Services::TicketNumberModifier.call(resource, params)
    if result.failure?
      flash[:error] = result.msg
    else
      flash[:success] = '票数修改成功'
    end
    redirect_to action: :show
  end

  member_action :change_status, method: :put do
    resource.send("#{params[:status]}!")
    render json: resource
  end
end
