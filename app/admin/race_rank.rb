ActiveAdmin.register RaceRank do
  config.filters = false
  config.batch_actions = false

  belongs_to :race
  navigation_menu :default
  menu false

  permit_params :ranking, :earning, :score, :player_id, :race_id
  index title: proc { "#{@race.name} - 排行榜" }, download_links: false do
    render 'index', context: self
  end

  controller do
    before_action :set_race, only: [:new, :create]
    def new
      @race_rank = @race.race_ranks.build
    end

    def create
      @race_rank = @race.race_ranks.build(permitted_params[:race_rank])
      respond_to do |format|
        if @race_rank.save
          format.html { redirect_to admin_race_race_ranks_path(@race), notice: 'rank新增成功。' }
          format.js
        else
          format.html { render :new }
          format.js
        end
      end
    end

    def set_race
      @race = Race.find(params[:race_id])
    end
  end

  config.clear_action_items!
  action_item :add, only: :index do
    link_to '新增排名', new_admin_race_race_rank_path(race), remote: true
  end
end
