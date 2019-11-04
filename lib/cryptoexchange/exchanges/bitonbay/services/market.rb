module Cryptoexchange::Exchanges
  module Bitonbay
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
          "#{Cryptoexchange::Exchanges::Bitonbay::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output['data'].map do |output|
            base = output["coin_type"]
            target = output["market_type"]
            
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Bitonbay::Market::NAME
                          )

            adapt(market_pair, output)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitonbay::Market::NAME
          ticker.last      = output["latest_price"]
          ticker.volume    = output["trade_vol_24h"]
          ticker.high      = output["max_price"]
          ticker.low       = output["min_price"]
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
