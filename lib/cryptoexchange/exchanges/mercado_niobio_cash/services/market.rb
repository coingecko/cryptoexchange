module Cryptoexchange::Exchanges
  module MercadoNiobioCash
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
          "#{Cryptoexchange::Exchanges::MercadoNiobioCash::Market::API_URL}"
        end

        def adapt_all(output)
          markets = output['markets']
          markets.map do |value|
            target, base = value['marketname'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: MercadoNiobioCash::Market::NAME
            )
            adapt(value, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = MercadoNiobioCash::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['NBR'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end