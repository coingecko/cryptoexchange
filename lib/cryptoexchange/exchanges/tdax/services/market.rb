module Cryptoexchange::Exchanges
  module Tdax
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          name = "#{market_pair.base}_#{market_pair.target}"

          "#{Cryptoexchange::Exchanges::Tdax::Market::API_URL}/public/getmarketsummaries?market=#{name}"
        end

        def adapt(output, market_pair)
          market = output.first
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Tdax::Market::NAME
          ticker.last      = NumericHelper.to_d(market['Last'])
          ticker.bid       = NumericHelper.to_d(market['Bid'])
          ticker.ask       = NumericHelper.to_d(market['Ask'])
          ticker.high      = NumericHelper.to_d(market['High'])
          ticker.low       = NumericHelper.to_d(market['Low'])
          ticker.volume    = NumericHelper.to_d(market['BaseVolume'])
          ticker.change    = NumericHelper.to_d(market['PercentChange'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
