class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render xml: @company }
      format.json { render json: @company }
    end
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company].permit(:name))
    @company.save
    flash[:notice] = 'New company successfully created'
    redirect_to @company
  end

end
