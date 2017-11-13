ActiveAdmin.register ExpressCode, namespace: :shop do
  config.batch_actions = false
  config.filters = false
  config.clear_action_items!
  menu priority: 19, parent: '运费管理'

  index download_links: false, paginator: false, pagination_total: false do
    render 'index'
  end
end
