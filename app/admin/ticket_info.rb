ActiveAdmin.register TicketInfo do
  member_action :change_number, method: :post do
    result = Services::TicketNumberModifier.call(resource, params)
    if result.failure?
      flash[:error] = result.msg
    else
      flash[:success] = result.msg
    end
    redirect_to admin_race_path(resource.race, anchor: 'ticket_manage')
  end
end
