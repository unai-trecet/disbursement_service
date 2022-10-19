require 'rails_helper'
require 'rake'

describe 'generate_weekly_disbursements task' do
 let (:current_time) { Time.current }

 before do
   Rake.application.rake_require "tasks/disbursements"
   Rake::Task.define_task(:environment)
 end

  it 'creates expected disbursements' do
    expect(CreateWeeklyDisbursementsJob).to_not receive(:perform_later).with(current_time).and_call_original
    Rake.application.invoke_task "disbursements:generate_weekly_disbursements"
  end
end