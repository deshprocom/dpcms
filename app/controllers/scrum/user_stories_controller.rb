class Scrum::UserStoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  def index
    @user_story = UserStory.new
    @stories = UserStory.all
  end

  def new
    @user_story = UserStory.new
  end

  def create
    @user_story = UserStory.new(user_story_params)
    if @user_story.save
      flash[:success] = '创建成功！'
      redirect_to scrum_user_stories_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit; end

  def update
    if @user_story.update(user_story_params)
      flash[:success] = '修改成功！'
      redirect_to [:scrum, @user_story]
    else
      render 'edit'
    end
  end

  def destroy
    @user_story.destroy
    flash[:success] = '删除成功！'
    redirect_to scrum_user_stories_path
  end

  private

  def user_story_params
    params.require(:user_story).permit(:name, :number, :score, :introduce, :status)
  end

  def set_story
    @user_story = UserStory.find(params[:id])
  end
end
