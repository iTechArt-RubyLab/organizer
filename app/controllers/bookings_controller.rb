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
    @booking.end_at = @booking.start_at + @booking.total_duration * 60 - 1

    if @booking.save
      end_at_set
      total_price_set
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

  def total_price_set
    @booking.total_price = (@booking.total_duration * 1.0 / @booking.service.duration).ceil * @booking.service.price
    @booking.save!
  end

  def end_at_set
    @booking.end_at = @booking.start_at + @booking.total_duration * 60 - 1
    @booking.save!
  end

end
