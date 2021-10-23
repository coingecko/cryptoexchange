module Cryptoexchange::Exchanges
  module Cashpayz
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
          "#{Cryptoexchange::Exchanges::Cashpayz::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output["Data"].map do |pair, ticker|
            target, base = pair.split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new({
                            base: base,
                            target: target,
                            market: Cashpayz::Market::NAME
                          })
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Cashpayz::Market::NAME

          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.low       = NumericHelper.to_d(output['low24hr'])
          ticker.high      = NumericHelper.to_d(output['high24hr'])
          ticker.bid       = NumericHelper.to_d(output['highestBid'])
          ticker.ask       = NumericHelper.to_d(output['lowestAskBid'])
          ticker.change    = NumericHelper.to_d(output['percentChange'])
          ticker.volume    = NumericHelper.to_d(output['quoteVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
