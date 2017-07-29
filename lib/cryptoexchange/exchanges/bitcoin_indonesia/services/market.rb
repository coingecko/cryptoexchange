module Cryptoexchange::Exchanges
  module BitcoinIndonesia
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
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::BitcoinIndonesia::Market::API_URL}/#{base}_#{target}/ticker"
        end

        def adapt(output, market_pair)
          output           = output['ticker']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BitcoinIndonesia::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output["vol_#{ticker.base.downcase}"])
          ticker.timestamp = output['server_time'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
