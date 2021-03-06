require 'doi2bibtex'

class PapersController < ApplicationController
  before_action :find_paper, only: [:edit, :update, :destroy, :bibtex]

  def index
    if params[:tags_name]
      @papers = Paper.tagged_with(params[:tags_name])
      tag_all
    else
      @papers = Paper.all
      tag_all
    end
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
    if doi.empty?
      redirect_to new_doi_papers_path, notice: "DOI is empty!"
    else
      bib = Doi2bibtex::Doi2bibtex.new(doi)
      puts bib
      if bib.bibtex.nil?
        redirect_to new_doi_papers_path, notice: "DOI not found!"
      else
        @paper = Paper.new(bib.to_h)
        @paper.bibtex = bib.bibtex
        if @paper.save
          redirect_to papers_path, notice: "new success!"
        else
          render :new_doi
        end
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

  def bibtex
    puts @paper.bibtex
  end

  def tag_all  # Get all tags
    @tag_cloud = Paper.tag_counts_on(:tags)
  end

  private

  def paper_params
    params.require(:paper).permit!
  end

  def find_paper
    @paper = Paper.find_by(id: params[:id])
  end
end
