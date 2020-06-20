class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(name: :asc)
  end

  def show
    id = params[:id]
    @passenger = Passenger.find(id)
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)
    if @passenger.save
      redirect_to passengers_path
    else
      render :new
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    if !@passenger.nil?
      if @passenger.update(passenger_params)
        redirect_to passenger_path
      else
        render :edit
      end
    else
      redirect_to passengers_path
    end
  end

  def destroy
    id = params[:id]
    @passenger = Passenger.find(id)
    if @passenger
      @passenger.destroy
    end
    redirect_to passengers_path
  end

  def mark_deactivate
    @passenger = Passenger.find(params[:id])
    @passenger.update(is_deactivated: true)
    @passenger.save
    redirect_to passenger_path(@passenger.id)
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num, :is_deactivated)
  end

end
