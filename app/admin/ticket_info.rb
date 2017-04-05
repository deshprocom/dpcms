ActiveAdmin.register TicketInfo do
  menu false
  member_action :change_number, method: :post do
    result = Services::TicketNumberModifier.call(resource, params)
    if result.failure?
      flash[:error] = result.msg
    else
      flash[:success] = '票数修改成功'
    end
    redirect_to admin_race_path(resource.race, anchor: 'ticket_manage')
  end
end
