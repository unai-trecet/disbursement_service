require 'rails_helper'

RSpec.describe 'Disbursements', type: :request do
  let(:selected_datetime) { Time.parse('17/10/2022') }
  let(:merchant1) { create(:merchant, name: 'Alpaca S.A.') }
  let(:merchant2) { create(:merchant) }

  let!(:order1) { create(:order, merchant: merchant1) }
  let!(:order2) { create(:order, merchant: merchant1) }
  let!(:order3) { create(:order, merchant: merchant1) }

  let!(:order4) { create(:order, merchant: merchant2) }
  let!(:order5) { create(:order, merchant: merchant2) }

  let!(:disbursement1) do
    create(:disbursement, merchant: merchant1, order: order1, created_at: selected_datetime - 1.day)
  end
  let!(:disbursement2) do
    create(:disbursement, merchant: merchant1, order: order2, created_at: selected_datetime - 2.days)
  end
  let!(:disbursement3) do
    create(:disbursement, merchant: merchant1, order: order3, created_at: selected_datetime - 8.days)
  end

  let!(:disbursement4) { create(:disbursement, merchant: merchant2, order: order4, created_at: selected_datetime) }
  let!(:disbursement5) do
    create(:disbursement, merchant: merchant2, order: order5, created_at: selected_datetime + 1.day)
  end

  describe 'GET /index' do
    context 'only date provided' do
      it 'returns http success with the expected data' do
        get '/disbursements/index', params: { date: selected_datetime }

        expect(response).to have_http_status(:success)

        body = JSON.parse(response.body)
        body_data = JSON.parse(response.body)['data']

        expect(body_data.count).to eq(3)
        expect(body_data.map { |el| el['id'] }).to match_array([disbursement1.id, disbursement2.id, disbursement4.id])
        expect(body['status']).to eq(200)
        expect(body['type']).to eq('Success')
        expect(body['message']).to eq('Disbursement list fetched successfully for date: 2022-10-17 00:00:00 +0200, merchant_name: not provided')
      end
    end

    context 'date and merchant name is provided' do
      it 'returns http success with the expected data' do
        get '/disbursements/index', params: { date: selected_datetime, merchant_name: 'Alpaca S.A.' }

        expect(response).to have_http_status(:success)

        body = JSON.parse(response.body)
        body_data = body['data']

        expect(body_data.count).to eq(2)
        expect(body_data.map { |el| el['id'] }).to match_array([disbursement1.id, disbursement2.id])
        expect(body_data.map { |el| el['merchant']['name'] }).to match_array(['Alpaca S.A.', 'Alpaca S.A.'])
        expect(body['status']).to eq(200)
        expect(body['type']).to eq('Success')
        expect(body['message']).to eq('Disbursement list fetched successfully for date: 2022-10-17 00:00:00 +0200, merchant_name: Alpaca S.A.')
      end
    end

    context 'no date is provided' do
      it 'returns http failure' do
        get '/disbursements/index'
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
