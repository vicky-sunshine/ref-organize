class PapersController < ApplicationController
  before_action :find_paper, only: [:edit, :update, :destroy]

  def index
    @papers = Paper.all
  end

  def new
    @paper = Paper.new
  end

  def create
    @paper = Paper.new(params[:paper])

    if @paper.save
      redirect_to papers_path, notice: "Create new paper successfully!"
    else
      render :new
    end
  end
  def edit
  end

  def update
    if @paper.update_attributes(paper_params)
      # 成功
      redirect_to papers_path, notice: "update success!"
    else
      # 失敗
      render :edit
    end
  end

  def create
    @paper = Paper.new(paper_params)

    if @paper.save
      redirect_to papers_path, notice: "new success!"
    else
      render :new
    end
  end

  def destroy
    @paper.destroy if @paper
    redirect_to papers_path, notice: "delete success!"
  end

  # def vote
  #   @paper.increment(:votes)
  #   @paper.save
  #   redirect_to papers_path, notice: "完成投票!"
  # end

  private

  def paper_params
    params.require(:paper).permit!
  end

  def find_paper
    @paper = Paper.find_by(id: params[:id])
  end
end
