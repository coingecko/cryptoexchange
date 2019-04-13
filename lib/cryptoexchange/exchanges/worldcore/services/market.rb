module Cryptoexchange::Exchanges
  module Worldcore
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
          "#{Cryptoexchange::Exchanges::Worldcore::Market::API_URL}/market/pairs"
        end

        def adapt_all(output)
          output['result']['pairs'].map do |pair|
            base, target = pair['pair']['pair_show'].split(' / ')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Worldcore::Market::NAME
            )
            adapt(market_pair, pair['data_market'])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Worldcore::Market::NAME
          ticker.last      = NumericHelper.to_d(output['close'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = output['date_now']/1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
