# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Player do
  menu label: '牌手管理', priority: 4
  filter :player_id
  filter :name
  filter :country

  index title: I18n.t('player.list') do
    column :player_id
    column '头像', :avatar do |player|
      if player.avatar_thumb.present?
        link_to image_tag(player.avatar_thumb, height: 100), player.avatar_thumb, target: '_blank'
      end
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
      @player = Player.new(player_params)
      respond_to do |format|
        if @player.save
          flash[:notice] = '新建牌手成功'
          format.html { redirect_to admin_player_url(@player) }
        else
          format.html { render :new }
        end
        format.js
      end
    end

    # def create
    #   @player = Player.new(player_params)
    #   if @player.save
    #     if player_params[:avatar].present?
    #       render :crop
    #     else
    #       flash[:notice] = '新建牌手成功'
    #       redirect_to admin_player_url(@player)
    #     end
    #   else
    #     render :new
    #   end
    # end

    def edit
      render :new
    end

    def update
      @player.crop_x = player_params[:crop_x]
      @player.crop_y = player_params[:crop_y]
      @player.crop_w = player_params[:crop_w]
      @player.crop_h = player_params[:crop_h]
      @player.assign_attributes(player_params)
      respond_to do |format|
        if @player.save
          flash[:notice] = '更新牌手成功'
          format.html { redirect_to admin_player_url(@player) }
        else
          format.html { render :edit }
        end
        format.js { render :create }
      end
    end

    # def update
    #   @player.assign_attributes(player_params)
    #   if @player.save
    #     if player_params[:avatar].present?
    #       render :crop
    #     else
    #       flash[:notice] = '更新牌手成功'
    #       redirect_to admin_player_url(@player)
    #     end
    #   else
    #     render :new
    #   end
    # end

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
                                     :memo,
                                     :crop_x, :crop_y, :crop_w, :crop_h)
    end

    def set_player
      @player = Player.find(params[:id])
    end
  end

  sidebar :'牌手数量', only: :index do
    "牌手总数量：#{Player.count}名"
  end
end
