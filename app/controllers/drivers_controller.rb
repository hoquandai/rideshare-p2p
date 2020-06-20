class DriversController < ApplicationController
  def index
    @drivers = Driver.all.order(name: :asc)
  end

  def show
    @driver = Driver.all.find(params[:id])
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      render :new
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    if !@driver.nil?
      @driver.update(driver_params) ? (redirect_to driver_path(@driver.id)) :
        (render :edit)
    else
      redirect_to drivers_path
    end
  end

  def is_deactivated
    @driver = Driver.find(params[:id])
    @driver.update(is_deactivated: true, is_available: false)
    redirect_to driver_path(@driver.id)
  end

  def destroy
    Driver.all.find(params[:id]).destroy
    redirect_to drivers_path
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :is_available, :vin, :car_make,
      :car_model, :is_deactivated)
  end
end
