module Cryptoexchange::Exchanges
  module Bigone
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
          "#{Cryptoexchange::Exchanges::Bigone::Market::API_URL}/#{market_pair.target}-#{market_pair.base}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bigone::Market::NAME
          ticker.last = NumericHelper.to_d(output["data"]["ticker"]["price"])
          ticker.high = NumericHelper.to_d(output["data"]["ticker"]["high"])
          ticker.low = NumericHelper.to_d(output["data"]["ticker"]["low"])
          ticker.volume = NumericHelper.to_d(output["data"]["ticker"]["volume"])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
