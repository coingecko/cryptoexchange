module Cryptoexchange::Exchanges
  module Qryptos
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(self.ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Qryptos::Market::API_URL}/products"
        end

        def adapt_all(output)
          output.map do |pair|
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: pair['base_currency'],
                            target: pair['quoted_currency'],
                            market: Qryptos::Market::NAME
                          )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Qryptos::Market::NAME
          #use last price 24h
          ticker.last      = NumericHelper.to_d(output['last_traded_price'])
          ticker.bid       = NumericHelper.to_d(output['market_bid'])
          ticker.ask       = NumericHelper.to_d(output['market_ask'])
          ticker.high      = NumericHelper.to_d(output['high_market_ask'])
          ticker.low       = NumericHelper.to_d(output['low_market_bid'])
          ticker.volume    = NumericHelper.to_d(output['volume_24h'])
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
