# rubocop:disable Metrics/BlockLength
ActiveAdmin.register RaceRank do
  config.filters = false
  config.batch_actions = false
  config.sort_order = 'ranking_asc'
  breadcrumb do
    if race.main?
      breadcrumb_links
    else
      path = admin_race_sub_race_race_blinds_path(race.parent, race)
      breadcrumb_links(path)
    end
  end

  belongs_to :race
  belongs_to :sub_race, optional: true

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
      flash[:notice] = '新建排名成功' if @race_rank.save
    end

    def update
      @race_rank.assign_attributes(rank_params)
      flash[:notice] = '更新排名成功' if @race_rank.save
      render :create
    end

    def destroy
      resource.destroy
      redirect_back fallback_location: admin_race_race_ranks_path(@race)
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

  member_action :player_table, method: :get do
    render 'player_table'
  end

  config.clear_action_items!
  action_item :add, only: :index do
    link_to '新增排名', new_admin_race_race_rank_path(race), remote: true
  end
end
