module Cryptoexchange::Exchanges
  module Bitstorage
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
          "#{Cryptoexchange::Exchanges::Bitstorage::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair['pairs'].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitstorage::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitstorage::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.divide(output['24H_volume'], ticker.last) if ticker.last > 0
          ticker.change    = NumericHelper.to_d(output['change'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
