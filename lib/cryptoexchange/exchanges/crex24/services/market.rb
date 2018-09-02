module Cryptoexchange::Exchanges
  module Crex24
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
          "#{Cryptoexchange::Exchanges::Crex24::Market::API_URL}/ReturnTicker"
        end

        def adapt_all(output)
          output['Tickers'].map do |ticker|
            target, base = ticker['PairName'].split("_")
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Crex24::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          market           = output
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Crex24::Market::NAME
          ticker.last      = NumericHelper.to_d(market['Last'])
          ticker.high      = NumericHelper.to_d(market['HighPrice'])
          ticker.low       = NumericHelper.to_d(market['LowPrice'])
          ticker.change    = NumericHelper.to_d(market['PercentChange'])
          ticker.volume    = NumericHelper.to_d(market['QuoteVolume'])
          ticker.timestamp = nil
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
