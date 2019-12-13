module Cryptoexchange::Exchanges
  module Bitsonic
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Bitsonic::Market::API_URL}/external/ticker/all"
        end

        def adapt_all(output)
          output["result"].map do |pair|
            market_pair = Cryptoexchange::Models::MarketPair.new(
                             base: pair["symbol"],
                             target: pair["market"],
                             market: Bitsonic::Market::NAME
                           )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitsonic::Market::NAME
          ticker.last      = NumericHelper.to_d(output['close'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['baseVolume']), ticker.last)
          ticker.change    = NumericHelper.to_d(output['priceChangePercent'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
