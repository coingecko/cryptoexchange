module Cryptoexchange::Exchanges
  module Bitrue
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
          "#{Cryptoexchange::Exchanges::Bitrue::Market::API_URL}/kline-api/public.json?command=returnTicker"
        end

        def adapt_all(output)
          output['data'].map do |pair, ticker|
            next if ticker['isFrozen'] == '1'
            base, target = pair.split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitrue::Market::NAME
            )
            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitrue::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid       = NumericHelper.to_d(output['highestBid'])
          ticker.high      = NumericHelper.to_d(output['high24hr'])
          ticker.low       = NumericHelper.to_d(output['low24hr'])
          ticker.volume    = NumericHelper.to_d(output['baseVolume'])
          ticker.change    = NumericHelper.to_d(output['percentChange'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
