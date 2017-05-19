ActiveAdmin.register Video do
  menu label: '视频管理', priority: 7



  action_item :add, only: :index do
    link_to '视频类别', admin_video_types_path
  end
end
