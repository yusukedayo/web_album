class RanksController < ApplicationController
  def new
    @rank = Rank.new
  end

  def create
    @rank = current_user.ranks.build(set_rank)
    if @rank.save
      redirect_to graduation_album_rank_path(@rank.graduation_album, @rank), notice: 'ランキングを投稿しました'
    else
      flash.now['alert'] = 'ランキング作成に失敗しました'
      render :new
    end
  end

  def edit
    @rank = Rank.find(params[:id])
  end

  def show
    @rank = Rank.find(params[:id])
    @rank_choices = @rank.rank_choices
  end

  def update
    @rank = Rank.find(params[:id])
    if @rank.update(set_rank)
      redirect_to graduation_album_rank_path(@rank.graduation_album, @rank), notice: 'ランキングを投稿しました'
    else
      flash.now['alert'] = 'ランキング編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @rank = Rank.find(params[:id])
    @rank.destroy!
    redirect_to root_path
  end

  private

  def set_rank
    params.require(:rank).permit(:rank_title, :rank_description).merge(graduation_album_id: params[:graduation_album_id])
  end
end
