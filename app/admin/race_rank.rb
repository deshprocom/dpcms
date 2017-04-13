ActiveAdmin.register RaceRank do
  config.filters = false
  config.batch_actions = false

  belongs_to :race
  navigation_menu :default
  menu false

  index title: proc { "#{@race.name} - 排行榜" }, download_links: false do
    render 'index', context: self
  end

  controller do
    before_action :set_race, only: [:new, :create, :edit, :update]
    before_action :set_race_rank, only: [:edit, :update]
    def new
      @race_rank = @race.race_ranks.build
    end

    def edit
      render :new
    end

    def create
      @race_rank = @race.race_ranks.build(rank_params)
      respond_to do |format|
        if @race_rank.save
          format.js
        else
          format.js
        end
      end
    end

    def update
      @race_rank.assign_attributes(rank_params)
      respond_to do |format|
        if @race_rank.save
          format.js { render :create }
        else
          format.js { render :create }
        end
      end
    end

    private
    def rank_params
      params.require(:race_rank).permit(:ranking,
                                        :earning,
                                        :score,
                                        :player_id)
    end

    def set_race
      @race = Race.find(params[:race_id])
    end

    def set_race_rank
      @race_rank = @race.race_ranks.find(params[:id])
    end
  end

  config.clear_action_items!
  action_item :add, only: :index do
    link_to '新增排名', new_admin_race_race_rank_path(race), remote: true
  end
end
