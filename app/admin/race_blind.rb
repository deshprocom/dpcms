# rubocop:disable Metrics/BlockLength
RACE_BLIND_TYPES = RaceBlind.blind_types.keys
TRANS_BLIND_TYPES = RACE_BLIND_TYPES.collect { |d| [I18n.t("race_blind.#{d}"), d] }
ActiveAdmin.register RaceBlind do
  config.filters = false
  config.batch_actions = false
  config.paginate = false
  config.sort_order = ''
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

  index download_links: false do
    render 'custom_index', race_blinds: race_blinds
  end
  form partial: 'form'
  controller do
    before_action :set_race, only: [:new, :create, :edit, :update]
    before_action :set_race_blind, only: [:edit, :update]

    def new
      @race_blind = @race.race_blinds.build
    end

    def edit
      render :new
    end

    def create
      @race_blind = @race.race_blinds.build(blind_params)
      flash[:notice] = '新建成功' if @race_blind.save
    end

    def update
      @race_blind.assign_attributes(blind_params)
      flash[:notice] = '更新成功' if @race_blind.save
      render :create
    end

    def scoped_collection
      super.level_asc
    end

    private

    def blind_params
      params.require(:race_blind).permit(:level,
                                         :small_blind,
                                         :big_blind,
                                         :race_time,
                                         :content,
                                         :blind_type,
                                         :ante)
    end

    def set_race
      @race = Race.find(params[:race_id])
    end

    def set_race_blind
      @race_blind = @race.race_blinds.find(params[:id])
    end
  end

  config.clear_action_items!
  action_item :add, only: :index do
    link_to '新增盲注结构', new_admin_race_race_blind_path(race), remote: true
  end
end
