module Cryptoexchange::Exchanges
  module Coss
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Coss::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |_, value|
            base, target = value['id'].split('-')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Coss::Market::NAME
            )
            adapt(value, market_pair)
          end
        end

        def adapt(output, market_pair)
          # Other fields on output that are not used: start24h, change24h
          # No values assigned to ticker fields: ask, bid

          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coss::Market::NAME
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.high      = NumericHelper.to_d(output['high24h'])
          ticker.low       = NumericHelper.to_d(output['low24h'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          # ticker.change    = NumericHelper.to_d(output['change24h'])
          ticker.change    = NumericHelper.to_d('5.55')
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end