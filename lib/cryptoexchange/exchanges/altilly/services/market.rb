module Cryptoexchange::Exchanges
  module Altilly
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
          "#{Cryptoexchange::Exchanges::Altilly::Market::API_URL}/public/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            adapt(pair)
          end
        end

        def adapt(output)
          base, target = output['symbol'].split(/(BTC$)+|(ETH$)+|(USDT$)+|(LTC$)+|(DOGE$)+/)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Altilly::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = DateTime.parse(output['timestamp']).to_time.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
