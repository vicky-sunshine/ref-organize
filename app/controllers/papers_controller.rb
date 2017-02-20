require 'doi2bibtex'

class PapersController < ApplicationController
  before_action :find_paper, only: [:edit, :update, :destroy]

  def index
    @papers = Paper.all
  end

  def new
    @paper = Paper.new
  end

  def new_doi
    @paper = Paper.new
  end

  def create
    @paper = Paper.new(paper_params)

    if @paper.save
      redirect_to papers_path, notice: "new success!"
    else
      render :new
    end
  end

  def create_doi
    doi = params[:paper][:doi]
    bib = Doi2bibtex::Doi2bibtex.new(doi)
    if bib.nil?
      redirect_to :new_doi, notice: "DOI not found!"
    else
      @paper = Paper.new(bib.to_h)
      if @paper.save
        redirect_to papers_path, notice: "new success!"
      else
        render :new_doi
      end
    end
  end

  def edit
  end

  def update
    if @paper.update_attributes(paper_params)
      redirect_to papers_path, notice: "update success!"
    else
      render :edit
    end
  end

  def destroy
    @paper.destroy if @paper
    redirect_to papers_path, notice: "delete success!"
  end

  private

  def paper_params
    params.require(:paper).permit!
  end

  def find_paper
    @paper = Paper.find_by(id: params[:id])
  end
end
