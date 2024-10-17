# frozen_string_literal: true

class CompanyMembersController < ApplicationController

  before_action :set_company

  # GET /companies/:company_id/members
  def index
    @users = @company.users.all

    render json: @users
  end

  # POST /companies/:company_id/members
  def create
    @user = User.find(params[:user_id])
    @company.users << @user

    render json: @company.users
  end

  def destroy
    @user = User.find(params[:id])
    @company.users.delete(@user)

    render json: @company.users
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:company_id])
  end

end
