module Cryptoexchange::Exchanges
  module Zgtop
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
          "#{Cryptoexchange::Exchanges::Zgtop::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['data'].map do |output|
            base, target = output['symbol'].split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Zgtop::Market::NAME
                          )
            adapt(output, market_pair)
          end
        end        

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Zgtop::Market::NAME

          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.last      = NumericHelper.to_d(output['prevClose'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
