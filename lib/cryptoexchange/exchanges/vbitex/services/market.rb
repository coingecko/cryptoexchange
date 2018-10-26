module Cryptoexchange::Exchanges
  module Vbitex
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
          "#{Cryptoexchange::Exchanges::Vbitex::Market::API_URL}/Home/markets/tickers.html"
        end


        def adapt_all(output)
          output.map { |market_data| adapt(market_data) }

        end

        def adapt(output)
          base, target     = output['symbol'].split('_')
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Vbitex::Market::NAME
          ticker.high      = NumericHelper.to_d(HashHelper.dig(output, '24H_max', 'price'))
          ticker.low       = NumericHelper.to_d(HashHelper.dig(output, '24H_min', 'price'))
          ticker.volume    = NumericHelper.to_d(output['volume_24h'])
          ticker.timestamp = NumericHelper.to_d(output['submit_time'])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
