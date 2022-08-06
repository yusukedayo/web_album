class RanksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rank, only: %i[update destroy edit show]
  def new
    @rank = Rank.new
  end

  def create
    @rank = current_user.ranks.build(params_rank)
    if @rank.save
      redirect_to graduation_album_rank_path(@rank.graduation_album, @rank), notice: 'ランキングを投稿しました'
    else
      flash.now['alert'] = 'ランキング作成に失敗しました'
      render :new
    end
  end

  def edit; end

  def show; end

  def update
    if @rank.update(params_rank)
      redirect_to graduation_album_rank_path(@rank.graduation_album, @rank), notice: 'ランキングを投稿しました'
    else
      flash.now['alert'] = 'ランキング編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @rank.destroy!
    redirect_to graduation_album_path(@rank.graduation_album)
  end

  private

  def params_rank
    params.require(:rank).permit(:rank_title, :rank_description).merge(graduation_album_id: params[:graduation_album_id])
  end

  def set_rank
    @rank = GraduationAlbum.find(params[:graduation_album_id]).ranks.find(params[:id])
  end
end
