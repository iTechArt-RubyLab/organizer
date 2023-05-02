class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :booking_set, only: %i[show edit update]

  def index
    @bookings = current_user.bookings.all
  end

  def show; end

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def booking_set
    @booking = current_user.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_at, :end_at, :total_price, :total_duration, :user_id, :service_id)
  end
end
