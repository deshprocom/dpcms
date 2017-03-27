ActiveAdmin.register TicketInfo do
  menu false
  member_action :change_number, method: :post do
    result = Services::TicketNumberModifier.call(resource, params)
    if result.failure?
      flash[:error] = result.msg
    else
      flash[:success] = '修改成功，请将售票状态更改回售票中'
    end
    redirect_to admin_race_path(resource.race, anchor: 'ticket_manage')
  end
end
