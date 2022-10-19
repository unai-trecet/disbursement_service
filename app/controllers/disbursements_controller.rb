class DisbursementsController < ApplicationController
  def index
    # TODO: All this filtering logic should be moved to a separate service that would handled
    # all of it letting the controller taking care only about params permission and response format.
    date = Time.parse(allowed_params[:date])
    starting_date = date - 1.week
    ending_date = date

    disbursements = if allowed_params[:merchant_name]
                      Disbursement.
                        includes(:order, :merchant).
                        joins(:merchant).
                        where('disbursements.created_at': starting_date..ending_date).
                        where('merchants.name = ?', allowed_params[:merchant_name])
                    else
                      Disbursement.
                        includes(:order, :merchant).
                        where('disbursements.created_at': starting_date..ending_date)
                    end

    render json: {
      data: ActiveModelSerializers::SerializableResource.new(disbursements, each_serializer: DisbursementSerializer),
      message: "Disbursement list fetched successfully for date: #{allowed_params.fetch(:date, 'not provided')}, merchant_name: #{allowed_params.fetch(:merchant_name, 'not provided')}",
      status: 200,
      type: 'Success'
    }
  end

  private

  def allowed_params
    params.permit(:date, :merchant_name)
  end
end
