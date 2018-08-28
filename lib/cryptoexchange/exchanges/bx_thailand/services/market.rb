module Cryptoexchange::Exchanges
  module BxThailand
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
          Cryptoexchange::Exchanges::BxThailand::Market::API_URL
        end

        def adapt_all(output)
          output.values.map do |ticker|
            base = ticker['secondary_currency']
            target = ticker['primary_currency']
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: BxThailand::Market::NAME
                          )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BxThailand::Market::NAME
          ticker.ask       = NumericHelper.to_d(HashHelper.dig(output, 'orderbook', 'asks', 'highbid'))
          ticker.bid       = NumericHelper.to_d(HashHelper.dig(output, 'orderbook', 'bids', 'highbid'))
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.volume    = NumericHelper.to_d(output['volume_24hours'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
