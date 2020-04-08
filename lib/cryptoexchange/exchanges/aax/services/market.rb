module Cryptoexchange::Exchanges
  module Aax
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
          "#{Cryptoexchange::Exchanges::Aax::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output["tickers"].map do |output|
            base, target = Abcc::Market.separate_symbol(output["s"])
            next if base == nil
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Aax::Market::NAME
            )

            adapt(output, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Aax::Market::NAME
          ticker.last      = NumericHelper.to_d(output['c'])
          ticker.volume    = NumericHelper.flip_volume(NumericHelper.to_d(output['v']), ticker.last)
          ticker.high      = NumericHelper.to_d(output['h'])
          ticker.low       = NumericHelper.to_d(output['l'])
          ticker.change    = NumericHelper.to_d(output['d'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
