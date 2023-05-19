class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :booking_set, only: %i[show edit update]
  before_action :authorize_booking

  def index
    @pagy, @bookings = pagy(current_user.bookings.all)

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

  def user_export
    @bookings = current_user.bookings.this_month
    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=#{DateTime.now}_bookings.csv"
      end
    end
  end

  def admin_export
    admin_id = User.where(role: 'admin')
    @bookings = Booking.where.not(user_id: admin_id).this_month
    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=#{DateTime.now}_report_services.csv"
      end
    end
  end

  private

  def booking_set
    @booking = current_user.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_at, :end_at, :total_price, :total_duration, :user_id, :service_id)
  end

  def authorize_booking
    authorize @booking || Booking
  end

end
