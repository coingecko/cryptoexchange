module Cryptoexchange::Exchanges
  module Hopex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output["data"])
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Hopex::Market::API_URL}/ticker?contractCode=#{market_pair.inst_id}"
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Hopex::Market::NAME
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id = market_pair.inst_id
          ticker.last = NumericHelper.to_d(output['lastPrice']).abs
          ticker.high = NumericHelper.to_d(output['price24Max'])
          ticker.low = NumericHelper.to_d(output['price24Min'])
          amount24h_usdt = output['amount24h'].split(" ")[0].delete(',').to_i
          ticker.volume = NumericHelper.divide(NumericHelper.to_d(amount24h_usdt), ticker.last)
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
