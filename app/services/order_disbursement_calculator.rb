require 'bigdecimal'

class OrderDisbursementCalculator
  SMALLER_AMOUNT_PERCENTAGE = 1
  INTERMIDIATE_AMOUNT_PERCENTAGE = 0.95
  BIG_AMOUNT_PERCENTAGE = 0.85

  def self.calculate_disbursement(order)
    return nil if order.completed_at.blank?

    amount_cents = order.amount.cents

    disbursement_amount = case amount_cents
                          when 0..4999
                            calculate_percentage(amount_cents, SMALLER_AMOUNT_PERCENTAGE)
                          when 5000..30_000
                            calculate_percentage(amount_cents, INTERMIDIATE_AMOUNT_PERCENTAGE)
                          else
                            calculate_percentage(amount_cents, BIG_AMOUNT_PERCENTAGE)
                          end

    Money.from_cents(disbursement_amount)
  rescue StandardError => e
    message = "Somethnig went wrong calculating order disbursement amount: #{e.message}"
    Logger.new($stderr).error(message)
  end

  def self.calculate_percentage(amount_cents, percentage)
    (BigDecimal(amount_cents) * (BigDecimal(percentage.to_s) / BigDecimal(100))).to_s('F')
  end
end
