module Cryptoexchange::Exchanges
  module Etorox
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
          "#{Cryptoexchange::Exchanges::Etorox::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output["instruments"].map do |ticker|
            base, target = Etorox::Market.separate_symbol(ticker["id"])
            next if base.nil? || target.nil?
            
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Etorox::Market::NAME
                          )

            adapt(market_pair, ticker)
          end.compact
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Etorox::Market::NAME
          ticker.ask = NumericHelper.to_d(output["lowestAsk"])
          ticker.bid = NumericHelper.to_d(output["highestBid"])
          ticker.last = NumericHelper.to_d(output["lastPrice"])
          ticker.high = NumericHelper.to_d(output["high24hr"])
          ticker.low = NumericHelper.to_d(output["low24hr"])
          ticker.volume = NumericHelper.to_d(output["baseVolume"])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
