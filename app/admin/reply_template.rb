# rubocop:disable Metrics/BlockLength
ActiveAdmin.register ReplyTemplate do
  menu false
  permit_params :type_id, :content

  form partial: 'form'

  controller do
    def new
      @template = ReplyTemplate.new
    end

    def create
      @template = ReplyTemplate.new(reply_template_params)
      respond_to do |format|
        if @template.save
          flash[:notice] = '新建模版成功'
          format.html { redirect_to admin_reply_templates_url(@template) }
        else
          format.html { render :new }
        end
        format.js
      end
    end

    private

    def reply_template_params
      params.require(:reply_template).permit(:type_id, :content)
    end
  end

  member_action :reply_template_table, method: :get do
    render 'reply_table'
  end
end
