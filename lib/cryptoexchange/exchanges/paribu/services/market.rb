module Cryptoexchange::Exchanges
  module Paribu
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
          "#{Cryptoexchange::Exchanges::Paribu::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            base, target = pair.split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Paribu::Market::NAME
            )
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Paribu::Market::NAME
          ticker.ask = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid = NumericHelper.to_d(output['highestBid'])
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.high = NumericHelper.to_d(output['high24hr'])
          ticker.low = NumericHelper.to_d(output['low24hr'])
          ticker.volume = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
