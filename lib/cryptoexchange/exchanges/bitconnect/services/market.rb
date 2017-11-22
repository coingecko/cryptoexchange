module Cryptoexchange::Exchanges
  module Bitconnect
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
          "#{Cryptoexchange::Exchanges::Bitconnect::Market::API_URL}/info"
        end

        def adapt_all(output)
          markets = output['markets']
          markets.map do |value|
            base, target = value['marketname'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Bitconnect::Market::NAME
            )
            adapt(value, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitconnect::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.high      = NumericHelper.to_d(output['high24h'])
          ticker.low       = NumericHelper.to_d(output['low24h'])
          ticker.volume    = NumericHelper.to_d(output['volume24h'])
          ticker.change    = NumericHelper.to_d(output['change24h'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
