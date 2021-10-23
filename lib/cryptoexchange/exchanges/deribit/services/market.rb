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
          output = super(ticker_url(market_pair))
          adapt(output["result"], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/getsummary?instrument=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Deribit::Market::NAME
          ticker.inst_id = market_pair.inst_id
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.ask = NumericHelper.to_d(output['askPrice'])
          ticker.bid = NumericHelper.to_d(output['bidPrice'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.to_d(output["volume#{market_pair.base.capitalize}"])
          ticker.contract_interval = market_pair.contract_interval
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
