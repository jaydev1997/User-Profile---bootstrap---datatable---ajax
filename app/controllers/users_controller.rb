class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    respond_to do |format|
      format.html
      format.json { render json: UsersDatatable.new(view_context) }
    end
  end

  def new
    @user = User.new
    @user.locations.new
    respond_modal_with @user
    # this is needed to seed the form with inputs for source
  end

  def show
  end

  def edit
    respond_modal_with @user
  end

  def create
    @user = User.new(user_params)
    @user.save!
    respond_modal_with @user, location: users_path
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.js do
          render file: '/users/update.js.erb'
        end


        # respond_modal_with @user, location: users_path
      else
        # respond_modal_with @user, location: users_path
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name,
                                   :email, :mobile, :age, :dob,
                                   locations_attributes: [ :address, :location_name, :phone_number,
                                                           :district, :city, :postcode, :country, :lat, :long]
                                   )
    end
end
