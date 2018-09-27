module Cryptoexchange::Exchanges
  module Oax
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end
        HTTP_METHOD = 'POST'

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Oax::Market::API_URL}/market/getAllMarketInfo"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair[0].split('/')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Oax::Market::NAME
            )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Oax::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'].to_f)
          ticker.high      = NumericHelper.to_d(output['high'].to_f)
          ticker.low       = NumericHelper.to_d(output['low'].to_f)
          ticker.bid       = NumericHelper.to_d(output['buy'].to_f)
          ticker.ask       = NumericHelper.to_d(output['sell'].to_f)
          ticker.volume    = NumericHelper.to_d(output['volume'].to_f)
          ticker.change    = NumericHelper.to_d(output['changeRate'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
