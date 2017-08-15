module Cryptoexchange::Exchanges
  module Viabtc
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Viabtc::Market::API_URL}/market/ticker?market=#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          output_data = output['data']
          output_data_ticker = output_data['ticker']

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Viabtc::Market::NAME
          ticker.ask       = NumericHelper.to_d(output_data_ticker['sell'])
          ticker.bid       = NumericHelper.to_d(output_data_ticker['buy'])
          ticker.last      = NumericHelper.to_d(output_data_ticker['last'])
          ticker.high      = NumericHelper.to_d(output_data_ticker['high'])
          ticker.low       = NumericHelper.to_d(output_data_ticker['low'])
          ticker.volume    = NumericHelper.to_d(output_data_ticker['vol'])
          ticker.timestamp = output_data['date'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
