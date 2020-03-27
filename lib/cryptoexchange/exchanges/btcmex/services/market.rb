module Cryptoexchange::Exchanges
  module Btcmex
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
          "#{Cryptoexchange::Exchanges::Btcmex::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            adapt(pair, ticker)
          end
        end

        def adapt(pair, output)
          base, target     = pair.split("USD")[0], "USD"
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.inst_id   = pair
          ticker.contract_interval = "perpetual"
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Btcmex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.volume    = NumericHelper.to_d(output['baseVolume'])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
