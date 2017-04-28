# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Player do
  menu label: '牌手管理', priority: 4
  filter :player_id
  filter :name
  filter :country

  index title: I18n.t('player.list') do
    column :player_id
    column '头像', :avatar do |player|
      image_tag(player.avatar_path, height: 60) if player.avatar_path.present?
    end
    column :name
    column :country
    column :dpi_total_earning
    column :dpi_total_score
    column :memo
    actions name: '操作'
  end

  show do
    render 'show', context: self
  end

  form partial: 'form'

  controller do
    before_action :set_player, only: [:edit, :update]

    def new
      @player = Player.new
    end

    def create
      @player = Player.create(player_params)
      flash[:notice] = '新建牌手成功' if @player.save
      respond_to do |format|
        if @player.save
          format.html { redirect_to admin_player_url(@player) }
        else
          format.html { render :new }
        end
        format.js
      end
    end

    def edit
      render :new
    end

    def update
      @player.assign_attributes(player_params)
      flash[:notice] = '更新牌手成功' if @player.save
      respond_to do |format|
        format.html { redirect_to admin_player_url(@player) }
        format.js { render :create }
      end
    end

    def destroy
      if resource.race_ranks.exists?
        flash[:notice] = '排名表中已存在的牌手不可删除'
      else
        resource.destroy
      end
      redirect_back fallback_location: admin_players_url
    end

    def player_params
      params.require(:player).permit(:name,
                                     :avatar,
                                     :country,
                                     :dpi_total_earning,
                                     :dpi_total_score,
                                     :memo)
    end

    def set_player
      @player = Player.find(params[:id])
    end
  end

  sidebar :'牌手数量', only: :index do
    "牌手总数量：#{Player.count}名"
  end
end
