class RankChoicesController < ApplicationController
  before_action :authenticate_user!
  def new
    @rank_choice = RankChoice.new
  end

  def create
    @rank_choice = RankChoice.new(set_rank_choice)
    if @rank_choice.save
      redirect_to graduation_album_rank_path(@rank_choice.rank.graduation_album, @rank_choice.rank), notice: '選択肢を投稿しました'
    else
      flash.now['alert'] = '選択肢作成に失敗しました'
      render :new
    end
  end

  def edit
    @rank_choice = RankChoice.find(params[:id])
  end

  def update
    @rank_choice = RankChoice.find(params[:id])
    if @rank_choice.update(set_rank_choice)
      redirect_to graduation_album_rank_path(@rank_choice.rank.graduation_album, @rank_choice.rank), notice: '選択肢を編集しました'
    else
      flash.now['alert'] = '選択肢編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @rank_choice = RankChoice.find(params[:id])
    @rank_choice.destroy!
    redirect_to graduation_album_rank_path(@rank_choice.rank.graduation_album, @rank_choice.rank), notice: '選択肢を削除しました'
  end

  private

  def set_rank_choice
    params.require(:rank_choice).permit(:content).merge(rank_id: params[:rank_id])
  end
end
