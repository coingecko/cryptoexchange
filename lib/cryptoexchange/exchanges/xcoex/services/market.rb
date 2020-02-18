module Cryptoexchange::Exchanges
  module Xcoex
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
          "#{Cryptoexchange::Exchanges::Xcoex::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |output|
            base, target = Xcoex::Market.separate_symbol(output["Symbol"])
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Xcoex::Market::NAME
                          )

            adapt(market_pair, output)
          end.compact
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Xcoex::Market::NAME
          ticker.last      = NumericHelper.to_d(output["LastBuyVolume"])
          ticker.volume    = NumericHelper.to_d(output["DailyTradedTotalVolume"])
          ticker.ask       = NumericHelper.to_d(output["BestAsk"])
          ticker.bid       = NumericHelper.to_d(output["BestBid"])          
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
