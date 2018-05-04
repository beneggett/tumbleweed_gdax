# frozen_string_literal: true

desc 'Clear completed/cancelled trades'
task clear_trades: :environment do
  Bot.log('Clear Sales')
  begin
    FlippedTrade.pending_sells.destroy_all
  rescue StandardError => e
    Bot.log("ERROR clearing sales: ", e, :error)
  end
  puts "Trades Cleared"
end
