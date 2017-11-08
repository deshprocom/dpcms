# rubocop:disable Metrics/BlockLength
HOTINFO_SOURCE_TYPE = %w(info video).freeze
TRANS_HOTINFO_SOURCE_TYPE = HOTINFO_SOURCE_TYPE.collect { |d| [I18n.t("activerecord.models.#{d}"), d] }
ActiveAdmin.register HotInfo do
  menu priority: 5, parent: '首页管理'
  config.batch_actions = false
  config.filters = false
  config.sort_order = 'position_asc'

  form partial: 'form'

  index do
    render 'index', context: self
  end

  controller do
    def create
      position = 100_000
      # 新建的position 默认为 100000
      merge_params = { position: position, source_type: hot_info_params[:source_type].classify }
      @hot_info = HotInfo.new hot_info_params.merge(merge_params)

      if @hot_info.save
        flash[:notice] = '增加热门资讯成功'

        # 新建成功，重新排序所有的position
        HotInfo.default_order.each do |info|
          position += 100_000
          info.update(position: position)
        end
        redirect_to admin_hot_infos_url
      else
        render :new
      end
    end

    def hot_info_params
      params.require(:hot_info).permit(:source_id,
                                       :source_type)
    end
  end

  member_action :reposition, method: :post do
    hot_info = HotInfo.find(params[:id])
    next_hot_info = params[:next_id] && HotInfo.find(params[:next_id].split('_').last)
    prev_hot_info = params[:prev_id] && HotInfo.find(params[:prev_id].split('_').last)
    position = if params[:prev_id].blank?
                 next_hot_info.position / 2
               elsif params[:next_id].blank?
                 prev_hot_info.position + 100000
               else
                 (prev_hot_info.position + next_hot_info.position) / 2
               end
    hot_info.update(position: position)
  end
end
