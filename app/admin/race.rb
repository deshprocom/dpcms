ActiveAdmin.register Race do

  menu label: '赛事列表', priority: 2
  permit_params :name, :logo, :prize, :location, :begin_date, :end_date, :status
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  sidebar '赛事详情', only: [:show, :edit] do
    ul do
      li link_to '该赛事的票', admin_race_tickets_path(resource)
    end
  end


end
