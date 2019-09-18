module Cryptoexchange::Exchanges
  module Deribit
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          instruments = super(instruments_url(market_pair))
          output = super(ticker_url(market_pair))

          instrument = instruments["result"].select { |i| i['instrument_name'] == market_pair.inst_id }.first

          adapt(output["result"], market_pair, instrument)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/ticker?instrument_name=#{market_pair.inst_id}"
        end

        def instruments_url(market_pair)
          "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/get_instruments?currency=#{market_pair.base}&expired=false&kind=future"
        end

        def adapt(output, market_pair, instrument)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Deribit::Market::NAME
          ticker.last = NumericHelper.to_d(output['last_price'])
          ticker.ask = NumericHelper.to_d(output['best_ask_price'])
          ticker.bid = NumericHelper.to_d(output['best_bid_price'])
          ticker.high = NumericHelper.to_d(output['stats']['high'])
          ticker.low = NumericHelper.to_d(output['stats']['low'])
          ticker.volume = NumericHelper.to_d(output['stats']['volume'])
          
          if instrument['settlement_period'] != "perpetual"
            ticker.start_timestamp = instrument['creation_timestamp']
            ticker.expire_timestamp = instrument['expiration_timestamp']
          end

          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
