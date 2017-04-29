require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '15d' do
  Link.where(created_at: Time.now - 15.days).destroy_all
end