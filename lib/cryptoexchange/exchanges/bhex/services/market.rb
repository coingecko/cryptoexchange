module Cryptoexchange::Exchanges
  module Bhex
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
          "#{Cryptoexchange::Exchanges::Bhex::Market::API_URL}/ticker/24hr"
        end

        def adapt_all(output)
          output.map do |pair|
            separator   = /(|AT|BTC|USDT)\z/i =~ pair["symbol"]
            base        = pair["symbol"][0..separator - 1]
            target      = pair["symbol"][separator..-1]

            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Bhex::Market::NAME
                          )

            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bhex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.high      = NumericHelper.to_d(output['highPrice'])
          ticker.low       = NumericHelper.to_d(output['lowPrice'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
