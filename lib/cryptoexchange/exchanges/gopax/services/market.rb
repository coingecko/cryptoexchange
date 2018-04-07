module Cryptoexchange::Exchanges
  module Gopax
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          ticker1 = super(ticker_url_one(market_pair))
          ticker2 = super(ticker_url_two(market_pair))
          adapt(ticker1, ticker2, market_pair)
        end

        def ticker_url_one(market_pair)
          "#{Cryptoexchange::Exchanges::Gopax::Market::API_URL}/trading-pairs/#{market_pair.base}-#{market_pair.target}/ticker"
        end

        def ticker_url_two(market_pair)
          "#{Cryptoexchange::Exchanges::Gopax::Market::API_URL}/trading-pairs/#{market_pair.base}-#{market_pair.target}/stats"
        end

        def adapt(ticker1, ticker2, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Gopax::Market::NAME
          ticker.ask       = NumericHelper.to_d(ticker1['ask'])
          ticker.bid       = NumericHelper.to_d(ticker1['bid'])
          ticker.last      = NumericHelper.to_d(ticker1['price'])
          ticker.high      = NumericHelper.to_d(ticker2['high'])
          ticker.low       = NumericHelper.to_d(ticker2['low'])
          ticker.volume    = NumericHelper.to_d(ticker1['volume'])
          ticker.timestamp = DateTime.parse(ticker2['time']).to_time.to_i
          ticker.payload   = [ticker1, ticker2]
          ticker
        end
      end
    end
  end
end
