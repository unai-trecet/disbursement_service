class DisbursementCreator
  def initialize(order)
    log_error('No order was provided creating Disbursement') && return unless order.is_a?(Order)

    @order = order
  end

  def call
    Disbursement.create!(disbursement_params)
  rescue StandardError => e
    message = "Something went wrong creating a Disbursement: #{e.message}"
    log_error(message)
  end

  private

  def disbursement_params
    { amount: OrderDisbursementCalculator.calculate_disbursement(@order),
      order: @order,
      merchant: @order.merchant }
  end

  def log_error(message)
    Logger.new($stderr).error(message)
  end
end
