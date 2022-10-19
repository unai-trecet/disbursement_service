class CreateWeeklyDisbursementsJob < ApplicationJob
  queue_as :default

  def perform(date)
    log_error('No Time was provided to run CreateWeeklyDisbursementsJob') && return unless date.is_a?(Time)

    Merchant.includes(:orders).each do |merchant|
      starting_date = date - 1.week
      merchant.orders.where(completed_at: starting_date..date).each do |order|
        DisbursementCreator.new(order).call
      end
    end
  end

  def log_error(message)
    Logger.new($stderr).error(message)
  end
end
