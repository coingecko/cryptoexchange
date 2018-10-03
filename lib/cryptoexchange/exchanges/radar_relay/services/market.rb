module Cryptoexchange::Exchanges
  module RadarRelay
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          ticker_output = super(ticker_url(market_pair))
          stats_output  = super(stats_url(market_pair))
          adapt(market_pair, ticker_output, stats_output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::RadarRelay::Market::API_URL}/markets/#{market_pair.base}-#{market_pair.target}/ticker"
        end

        def stats_url(market_pair)
          "#{Cryptoexchange::Exchanges::RadarRelay::Market::API_URL}/markets/#{market_pair.base}-#{market_pair.target}/stats"
        end

        def adapt(market_pair, ticker_output, stats_output)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = RadarRelay::Market::NAME
          ticker.bid       = NumericHelper.to_d(ticker_output['bestBid'])
          ticker.ask       = NumericHelper.to_d(ticker_output['bestAsk'])
          ticker.last      = NumericHelper.to_d(ticker_output['price'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(stats_output['volume24Hour']), ticker.last)
          ticker.change    = NumericHelper.to_d(stats_output['percentChange24Hour'])
          ticker.timestamp = NumericHelper.to_d(ticker_output['timestamp'])
          ticker.payload   = [ticker_output, stats_output]
          ticker
        end
      end
    end
  end
end
