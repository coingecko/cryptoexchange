module Cryptoexchange::Exchanges
  module Bitmex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output[0], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/instrument?symbol=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bitmex::Market::NAME
          ticker.inst_id = market_pair.inst_id
          ticker.ask = NumericHelper.to_d(output['askPrice'])
          ticker.bid = NumericHelper.to_d(output['bidPrice'])
          ticker.last = NumericHelper.to_d(output['lastPrice'])
          ticker.high = NumericHelper.to_d(output['highPrice'])
          ticker.low = NumericHelper.to_d(output['lowPrice'])
          ticker.volume = NumericHelper.to_d(output['homeNotional24h'])
          ticker.contract_interval = market_pair.contract_interval
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
