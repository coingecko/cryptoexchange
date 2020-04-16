module Cryptoexchange::Exchanges
  module Chiliz
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
          "#{Cryptoexchange::Exchanges::Chiliz::Market::API_URL}/ticker/24hr"
        end

        def adapt_all(output)
          output.map do |output|
            base, target = Chiliz::Market.separate_symbol(output["symbol"])
            next if target.nil? || base.nil?

            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Chiliz::Market::NAME,
                          )

            adapt(market_pair, output)
          end.compact
        end

        def adapt(market_pair, ticker_output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Chiliz::Market::NAME
          ticker.last      = NumericHelper.to_d(ticker_output['lastPrice'])
          ticker.volume    = NumericHelper.to_d(ticker_output['volume'])
          ticker.high      = NumericHelper.to_d(ticker_output['highPrice'])
          ticker.low       = NumericHelper.to_d(ticker_output['lowPrice'])
          ticker.timestamp = nil
          ticker.payload   = ticker_output
          ticker
        end
      end
    end
  end
end
