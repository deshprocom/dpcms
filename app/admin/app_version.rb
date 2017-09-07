ActiveAdmin.register AppVersion do
  config.batch_actions = false
  config.filters = false

  permit_params :platform, :version, :force_upgrade
  form partial: 'form'
end
