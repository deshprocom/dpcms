class Scrum::AcsController < ApplicationController
  before_action :set_story, only: [:create, :new]
  before_action :set_ac, only: [:edit, :update, :destroy]

  def new
    @ac = Ac.new
  end

  def create
    @ac = @user_story.acs.new(ac_params)
    if @ac.save
      flash[:success] = '创建成功！'
      redirect_to scrum_user_story_path(@user_story)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @ac.update(ac_params)
      flash[:success] = '修改成功！'
      redirect_to [:scrum, @user_story]
    else
      render 'edit'
    end
  end

  def destroy
    @ac.destroy
    flash[:success] = '删除成功！'
    redirect_to scrum_user_story_path(@user_story)
  end

  private

  def set_story
    @user_story ||= UserStory.find(params[:user_story_id])
  end

  def set_ac
    @ac = set_story.acs.find(params[:id])
  end

  def ac_params
    params.require(:ac).permit(:number,
                                                 :given,
                                                 :when,
                                                 :than,
                                                 :uri)
  end
end
