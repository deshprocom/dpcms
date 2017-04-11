ActiveAdmin.register RaceRank do
  config.filters = false
  config.batch_actions = false

  belongs_to :race
  navigation_menu :default
  menu false

  permit_params :ranking, :earning, :score, :player_id, :race_id
end
