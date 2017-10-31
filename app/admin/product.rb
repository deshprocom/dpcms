# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Product do
  config.batch_actions = false

  permit_params :title, :icon, :description, :type, :category_id
  form partial: 'form'
end
