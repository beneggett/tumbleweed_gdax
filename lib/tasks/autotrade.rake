# frozen_string_literal: true

desc 'creates performance metrics records at set interval'
task begin_trading: :environment do
  begin
    Trader.begin_trade_cycle
  rescue StandardError => e
    Bot.log("ERROR: ", e, :error)
  end
  Bot.log('If you have outstanding trades, make sure to cancel them')
end
