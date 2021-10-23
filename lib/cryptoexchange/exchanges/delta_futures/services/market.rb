module Cryptoexchange::Exchanges
  module DeltaFutures
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::DeltaFutures::Market::API_URL}/v2/tickers"
        end

        def adapt(output, market_pair)
          output = output['result'].find { |t| t["symbol"] == market_pair.inst_id }
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = DeltaFutures::Market::NAME
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id = market_pair.inst_id
          ticker.last = NumericHelper.to_d(output['close'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])

          #special handling of volume for this exchange
          volume = if market_pair.target == "USD"
                    NumericHelper.divide(NumericHelper.to_d(output['volume']), ticker.last)
                  else
                    NumericHelper.to_d(output['volume'])
                  end

          ticker.volume = volume
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
