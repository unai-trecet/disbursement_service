require 'rails_helper'

RSpec.describe CreateWeeklyDisbursementsJob, type: :job do
  let(:selected_datetime) { Time.parse('17/10/2022') }
  let(:merchant1) { create(:merchant) }
  let(:merchant2) { create(:merchant) }

  let!(:on_week_orders1) { create(:order, merchant: merchant1, completed_at: selected_datetime - 1.day) }
  let!(:on_week_orders2) { create(:order, merchant: merchant1, completed_at: selected_datetime - 7.day) }
  let!(:on_week_orders3) { create(:order, merchant: merchant2, completed_at: selected_datetime - 2.day) }

  let!(:not_on_week_order1) { create(:order, merchant: merchant1, completed_at: selected_datetime - 8.day) }
  let!(:not_on_week_order2) { create(:order, merchant: merchant2, completed_at: selected_datetime + 1.day) }

  let!(:on_week_orders_not_completed) { create(:order, merchant: merchant1, completed_at: nil) }

  describe 'correct date passed' do
    it 'creates expected disbursements in a given date\'s week' do
      expect do
        described_class.perform_now(selected_datetime)
      end.to change(Disbursement, :count).from(0).to(3)
      all_disbursements = Disbursement.all

      expect(all_disbursements.map(&:merchant)).to match_array([merchant1, merchant1, merchant2])
      expect(all_disbursements.map(&:order)).to match_array([on_week_orders1, on_week_orders2, on_week_orders3])
    end
  end

  describe 'wrong date or no provided' do
    it 'logs error when no date is passed' do
      expect_any_instance_of(Logger).to receive(:error).and_call_original
      expect do
        described_class.perform_now('no date')
      end.not_to change(Disbursement, :count)
    end
  end
end
