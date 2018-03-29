module Cryptoexchange::Exchanges
  module Aex
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
          "#{Cryptoexchange::Exchanges::Aex::Market::API_URL}/ticker.php?c=#{base}&mk_type=#{target}"
        end

        def adapt(output, market_pair)
          market = output['ticker']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Aex::Market::NAME
          ticker.ask       = NumericHelper.to_d(market['sell'])
          ticker.bid       = NumericHelper.to_d(market['buy'])
          ticker.high      = NumericHelper.to_d(market['high'])
          ticker.low       = NumericHelper.to_d(market['low'])
          ticker.last      = NumericHelper.to_d(market['last'])
          ticker.volume    = NumericHelper.to_d(market['vol'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
