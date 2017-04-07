ActiveAdmin.register Player do
  menu label: '牌手管理', priority: 4
  permit_params :name, :avatar, :country, :dpi_total_earning, :dpi_total_score, :memo

  filter :player_id
  filter :name
  filter :country

  index title: I18n.t('player.list') do
    column :player_id
    column '头像', :avatar do |player|
      link_to image_tag(player.avatar_path, height: 60) if player.avatar_path.present?
    end
    column :name
    column :country
    column :dpi_total_earning
    column :dpi_total_score
    column :memo
    actions name: '操作'
  end

  form partial: 'form'

  sidebar :'牌手数量', only: :index do
    "牌手总数量：#{Player.count}名"
  end
end
