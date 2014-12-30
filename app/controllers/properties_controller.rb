class PropertiesController < ApplicationController
  before_action :set_property, only: [:edit, :update]
  before_action :set_categories, only: [:new, :create, :edit, :update]
  def new
    @property = Property.new
    @property.user = current_user
  end

  def create
    @property = Property.new(property_params)
    @property.user = current_user

    if @property.save
      redirect_to properties_path
    else
      render :new
    end
  end

  def show
    @property = Property.find(params[:id])
  end

  def update
    @property.update(property_params)
    if @property.save
      redirect_to properties_path
    else
      render :edit
    end
  end

  def edit
  end

  def index
    @properties = Property.active
  end

  private
  def set_property
    @property = Property.find(params[:id])
  end

  def set_categories
    @categories = Category.pluck(:name, :id)
  end

  def property_params
    params.require(:property).permit(:title, :description, :price, :retired, :occupancy, :bathroom_private, :user_id, :category_id, address_attributes: [:id, :line_1, :line_2, :city, :state, :zip, :country], photo_attributes: [:image])
  end
end
