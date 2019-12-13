module Cryptoexchange::Exchanges
  module Coinfalcon
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output['data'])
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Coinfalcon::Market::API_URL}markets/"
        end

        def adapt_all(output)
          output.map do |ticker|
                pair_split= ticker['name'].split('-')
                market_pair = Cryptoexchange::Models::MarketPair.new(
                                base: pair_split[0],
                                target: pair_split[1],
                                market: Coinfalcon::Market::NAME
                              )
                adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinfalcon::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.volume    =  NumericHelper.divide(NumericHelper.to_d(output['volume']), ticker.last)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
