class CompaniesController < ApplicationController
  before_filter :authenticate_user!

  before_filter :only_admins_create_update_company, only: [:new, :create, :edit, :update]

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
    if @company.save
      flash[:notice] = 'New company successfully created'
      redirect_to @company
    else
      render 'new'
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    if @company.update(params[:company].permit(:name))
      flash[:notice] = 'Company successfully updated'
      redirect_to @company
    else
      render 'edit'
    end

  end

  def only_admins_create_update_company
    redirect_to companies_path, :alert => 'Only admins can create or update a company' unless current_user.admin
  end

end
