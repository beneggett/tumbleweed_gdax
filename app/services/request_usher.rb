# frozen_string_literal: true

class RequestUsher
  PASS_THRU_ERR_MSGS = ['NotFound', 'Order already done'].freeze

  class << self
    attr_accessor :last_request_time

    def last_request_time
      @last_request_time || Time.zone.now
    end

    def execute(meth, *args)
      begin
        throttle

        resp = JSON.parse(Request.send(meth, *args))
      rescue StandardError => e # There are only two errors to not retry
        Bot.log("API ERROR! Msg: #{e.message}, Class: #{e.class}. ", e, :error)
        if e.is_a? Coinbase::Exchange::NotFoundError
          initial_trade_not_found_count = Rails.cache.fetch("trade_#{args.join.underscore}", expires_in: 1.day) { 0 }
          Rails.cache.write("trade_#{args.join.underscore}", initial_trade_not_found_count +=1, expires_in: 1.day)
          updated_trade_not_found_count = Rails.cache.read("trade_#{args.join.underscore}")
          if updated_trade_not_found_count > 3
            FlippedTrade.by_order_id(args).destroy_all
            Bot.log(Rainbow("Deleting Flipped Trade").red.underline)
            Rails.cache.delete("trade_#{args.join.underscore}")
          end
        end
        retry unless pass_thru_error?(e.message)
      end

      resp || format_error(e.message)
    end

    def throttle
      throttle_min = ENV['THROTTLE_MIN'].to_f
      delta = Time.zone.now - last_request_time
      Bot.sleep(throttle_min - delta) if delta < throttle_min

      @last_request_time = Time.zone.now
    end

    def pass_thru_error?(err_msg)
      PASS_THRU_ERR_MSGS.include? format_error(err_msg)['message']
    end

    def format_error(err_msg)
      err_msg.is_json? ? JSON.parse(err_msg) : { 'message' => err_msg }
    end
  end
end
