module Cryptoexchange::Exchanges
  module Bitpanda
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
          "#{Cryptoexchange::Exchanges::Bitpanda::Market::API_URL}/market-ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            next unless pair['state'] == 'ACTIVE'
            base, target = pair["instrument_code"].split("_")

            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base:   base,
                            target: target,
                            market: Bitpanda::Market::NAME
                          )
            adapt(pair, market_pair)
          end.compact
        end        

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          base = market_pair.base
          target = market_pair.target
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Bitpanda::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.change    = NumericHelper.to_d(output['price_change_percentage'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['quote_volume']), ticker.last)
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
