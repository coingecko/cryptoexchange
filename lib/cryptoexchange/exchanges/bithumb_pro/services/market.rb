module Cryptoexchange::Exchanges
  module BithumbGlobal
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::BithumbGlobal::Market::API_URL}/spot/ticker?symbol=ALL"
        end

        def adapt_all(output)
          output['data'].map do |ticker|
            base, target = ticker["s"].split("-")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: BithumbGlobal::Market::NAME
              )

            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = BithumbGlobal::Market::NAME
          ticker.last = NumericHelper.to_d(output['c'])
          ticker.high = NumericHelper.to_d(output['h'])
          ticker.low = NumericHelper.to_d(output['l'])
          ticker.volume = NumericHelper.to_d(output['v'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
