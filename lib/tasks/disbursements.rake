namespace :disbursements do
  desc 'Generates disbursements within a week on current date minus seven days'
  task generate_weekly_disbursements: :environment do
    CreateWeeklyDisbursementsJob.perform_later(Time.current)
  end
end
